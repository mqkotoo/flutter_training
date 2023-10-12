import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/service/weather_service.dart';
import 'package:flutter_training/utils/error/error_message.dart';
import 'package:flutter_training/view/weather_view/component/weather_forecast_panel.dart';
import 'package:flutter_training/view/weather_view/weather_page.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import '../service/weather_service_test.mocks.dart';
import '../utils/dummy_data.dart';
import '../utils/utils.dart';

void main() {
  setUpAll(setDisplayVertical);
  tearDownAll(teardownDeviceSize);

  final mockClient = MockYumemiWeather();

  testWidgets('initial screen', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: WeatherPage(),
        ),
      ),
    );

    // 気温のテキストの色を取得
    final minTemp =
        tester.firstWidget(find.byKey(WeatherForecastPanel.minTempKey)) as Text;
    final minTempColor = minTemp.style!.color;

    final maxTemp =
        tester.firstWidget(find.byKey(WeatherForecastPanel.maxTempKey)) as Text;
    final maxTempColor = maxTemp.style!.color;

    expect(find.byType(Placeholder), findsOneWidget);

    expect(find.byKey(WeatherForecastPanel.maxTempKey), findsOneWidget);
    expect(find.byKey(WeatherForecastPanel.minTempKey), findsOneWidget);

    expect(find.text('** ℃'), findsNWidgets(2));
    expect(find.text('Close'), findsOneWidget);
    expect(find.text('Reload'), findsOneWidget);

    expect(minTempColor, Colors.blue);
    expect(maxTempColor, Colors.red);
  });

  group('after getting the weather', () {
    // cloudy
    testWidgets(
        'when reload button is pressed, '
        'cloudy weather and correct temperature should be displayed.',
        (tester) async {
      when(mockClient.fetchWeather(any)).thenReturn(cloudyWeatherJsonData);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            yumemiWeatherClientProvider.overrideWithValue(mockClient)
          ],
          child: const MaterialApp(
            home: WeatherPage(),
          ),
        ),
      );

      // 気温のテキストの色を取得
      final minTemp = tester
          .firstWidget(find.byKey(WeatherForecastPanel.minTempKey)) as Text;
      final minTempColor = minTemp.style!.color;

      final maxTemp = tester
          .firstWidget(find.byKey(WeatherForecastPanel.maxTempKey)) as Text;
      final maxTempColor = maxTemp.style!.color;

      expect(find.byType(Placeholder), findsOneWidget);
      expect(find.text('** ℃'), findsNWidgets(2));

      await tester.tap(find.byKey(WeatherPage.reloadButton));
      await tester.pump();

      expect(find.byType(Placeholder), findsNothing);
      expect(find.text('** ℃'), findsNothing);

      expect(
        find.bySemanticsLabel(WeatherSvgImage.cloudyLabel),
        findsOneWidget,
      );

      expect(find.text('25 ℃'), findsOneWidget);
      expect(find.text('7 ℃'), findsOneWidget);

      expect(minTempColor, Colors.blue);
      expect(maxTempColor, Colors.red);
    });

    // sunny
    testWidgets(
        'when reload button is pressed, '
        'sunny weather and correct temperature should be displayed.',
        (tester) async {
      when(mockClient.fetchWeather(any)).thenReturn(sunnyWeatherJsonData);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            yumemiWeatherClientProvider.overrideWithValue(mockClient)
          ],
          child: const MaterialApp(
            home: WeatherPage(),
          ),
        ),
      );

      expect(find.byType(Placeholder), findsOneWidget);
      expect(find.text('** ℃'), findsNWidgets(2));

      await tester.tap(find.byKey(WeatherPage.reloadButton));
      await tester.pump();

      expect(find.byType(Placeholder), findsNothing);
      expect(find.text('** ℃'), findsNothing);

      expect(
        find.bySemanticsLabel(WeatherSvgImage.sunnyLabel),
        findsOneWidget,
      );

      expect(find.text('30 ℃'), findsOneWidget);
      expect(find.text('0 ℃'), findsOneWidget);
    });

    // rainy
    testWidgets(
        'when reload button is pressed, '
        'rainy weather and correct temperature should be displayed.',
        (tester) async {
      when(mockClient.fetchWeather(any)).thenReturn(rainyWeatherJsonData);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            yumemiWeatherClientProvider.overrideWithValue(mockClient)
          ],
          child: const MaterialApp(
            home: WeatherPage(),
          ),
        ),
      );

      expect(find.byType(Placeholder), findsOneWidget);
      expect(find.text('** ℃'), findsNWidgets(2));

      await tester.tap(find.byKey(WeatherPage.reloadButton));
      await tester.pump();

      expect(find.byType(Placeholder), findsNothing);
      expect(find.text('** ℃'), findsNothing);

      expect(
        find.bySemanticsLabel(WeatherSvgImage.rainyLabel),
        findsOneWidget,
      );

      expect(find.text('44 ℃'), findsOneWidget);
      expect(find.text('-22 ℃'), findsOneWidget);
    });
  });

  group('when an error occurs', () {
    // invalidParameter
    testWidgets(
        'when fetchWeather() returns failure with invalidParameter error, '
        'error dialog and correct message should be visible. '
        'Then the dialog is closed by pressing the ok button.', (tester) async {
      when(mockClient.fetchWeather(any))
          .thenThrow(YumemiWeatherError.invalidParameter);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            yumemiWeatherClientProvider.overrideWithValue(mockClient)
          ],
          child: const MaterialApp(
            home: WeatherPage(),
          ),
        ),
      );

      expect(
        find.widgetWithText(AlertDialog, ErrorMessage.invalidParameter),
        findsNothing,
      );

      await tester.tap(find.byKey(WeatherPage.reloadButton));
      await tester.pump();

      expect(
        find.widgetWithText(AlertDialog, ErrorMessage.invalidParameter),
        findsOneWidget,
      );

      // ダイアログが、他の画面領域のタップで閉じないことを確認する
      await tester.tapAt(
        const Offset(5, 5),
      );
      await tester.pump();

      expect(
        find.widgetWithText(AlertDialog, ErrorMessage.invalidParameter),
        findsOneWidget,
      );

      await tester.tap(find.text('OK'));
      await tester.pump();

      expect(
        find.widgetWithText(AlertDialog, ErrorMessage.invalidParameter),
        findsNothing,
      );
    });

    // unknown
    testWidgets(
        'when fetchWeather() returns failure with unknown error, '
        'error dialog and correct message should be visible. ', (tester) async {
      when(mockClient.fetchWeather(any)).thenThrow(YumemiWeatherError.unknown);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            yumemiWeatherClientProvider.overrideWithValue(mockClient)
          ],
          child: const MaterialApp(
            home: WeatherPage(),
          ),
        ),
      );

      expect(
        find.widgetWithText(AlertDialog, ErrorMessage.unknown),
        findsNothing,
      );

      await tester.tap(find.byKey(WeatherPage.reloadButton));
      await tester.pump();

      expect(
        find.widgetWithText(AlertDialog, ErrorMessage.unknown),
        findsOneWidget,
      );

      await tester.tap(find.text('OK'));
      await tester.pump();

      expect(
        find.widgetWithText(AlertDialog, ErrorMessage.unknown),
        findsNothing,
      );
    });

    // CheckedFromJsonException
    testWidgets(
        'when fetchWeather() returns failure with CheckedFromJsonException, '
        'error dialog and correct message should be visible. ', (tester) async {
      when(mockClient.fetchWeather(any))
          .thenReturn(invalidJsonDataForCheckedFromJsonException);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            yumemiWeatherClientProvider.overrideWithValue(mockClient)
          ],
          child: const MaterialApp(
            home: WeatherPage(),
          ),
        ),
      );

      expect(
        find.widgetWithText(AlertDialog, ErrorMessage.receiveInvalidData),
        findsNothing,
      );

      await tester.tap(find.byKey(WeatherPage.reloadButton));
      await tester.pump();

      expect(
        find.widgetWithText(AlertDialog, ErrorMessage.receiveInvalidData),
        findsOneWidget,
      );

      await tester.tap(find.text('OK'));
      await tester.pump();

      expect(
        find.widgetWithText(AlertDialog, ErrorMessage.receiveInvalidData),
        findsNothing,
      );
    });

    // FormatException
    testWidgets(
        'when fetchWeather() returns failure with FormatException, '
        'error dialog and correct message should be visible. ', (tester) async {
      when(mockClient.fetchWeather(any))
          .thenReturn(invalidJsonDataForFormatException);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            yumemiWeatherClientProvider.overrideWithValue(mockClient)
          ],
          child: const MaterialApp(
            home: WeatherPage(),
          ),
        ),
      );

      expect(
        find.widgetWithText(AlertDialog, ErrorMessage.receiveInvalidData),
        findsNothing,
      );

      await tester.tap(find.byKey(WeatherPage.reloadButton));
      await tester.pump();

      expect(
        find.widgetWithText(AlertDialog, ErrorMessage.receiveInvalidData),
        findsOneWidget,
      );

      await tester.tap(find.text('OK'));
      await tester.pump();

      expect(
        find.widgetWithText(AlertDialog, ErrorMessage.receiveInvalidData),
        findsNothing,
      );
    });
  });
}
