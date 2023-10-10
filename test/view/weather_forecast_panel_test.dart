import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/view/weather_view/component/weather_forecast_panel.dart';
import 'package:flutter_training/view/weather_view/weather_page.dart';

import '../utils/utils.dart';

void main() {
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
}
