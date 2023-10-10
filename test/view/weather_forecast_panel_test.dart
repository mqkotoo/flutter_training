import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/service/weather_service.dart';
import 'package:flutter_training/view/weather_view/component/weather_forecast_panel.dart';
import 'package:flutter_training/view/weather_view/weather_page.dart';
import 'package:mockito/mockito.dart';

import '../service/weather_service_test.mocks.dart';
import '../utils/dummy_data.dart';
import '../utils/utils.dart';

void main() {
  final mockClient = MockYumemiWeather();

  testWidgets('initial screen', (tester) async {
    setDisplayVertical(tester: tester);

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

    teardownDeviceSize(tester);
  });

  group('after getting the weather', () {
    // cloudy
    testWidgets(
        'when reload button is pressed, '
        'cloudy weather and correct temperature should be displayed.',
        (tester) async {
      when(mockClient.fetchWeather(any)).thenReturn(cloudyWeatherJsonData);
      setDisplayVertical(tester: tester);

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

      expect(find.bySemanticsLabel('Cloudy image'), findsOneWidget);

      expect(find.text('25 ℃'), findsOneWidget);
      expect(find.text('7 ℃'), findsOneWidget);

      expect(minTempColor, Colors.blue);
      expect(maxTempColor, Colors.red);

      teardownDeviceSize(tester);
    });

    // sunny
    testWidgets(
        'when reload button is pressed, '
        'sunny weather and correct temperature should be displayed.',
        (tester) async {
      when(mockClient.fetchWeather(any)).thenReturn(sunnyWeatherJsonData);
      setDisplayVertical(tester: tester);

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

      expect(find.bySemanticsLabel('Sunny image'), findsOneWidget);

      expect(find.text('30 ℃'), findsOneWidget);
      expect(find.text('0 ℃'), findsOneWidget);

      teardownDeviceSize(tester);
    });
  });
}
