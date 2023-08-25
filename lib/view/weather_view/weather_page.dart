import 'package:flutter/material.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/utils/api/result.dart';
import 'package:flutter_training/utils/extention/enum.dart';
import 'package:flutter_training/view/weather_view/component/weather_forecast.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherCondition? weatherCondition;
  final _client = YumemiWeather();

  //天気を取得してweatherConditionに代入する
  Result<WeatherCondition?, String> fetchWeather() {
    try {
      final condition = _client.fetchThrowsWeather('Aichi');
      weatherCondition = WeatherCondition.values.byNameOrNull(condition);
      if (weatherCondition == null) {
        return const Failure<WeatherCondition, String>('unknown');
      }
      return Success<WeatherCondition?, String>(
        WeatherCondition.values.byNameOrNull(condition),
      );
    } on YumemiWeatherError catch (e) {
      switch (e) {
        case YumemiWeatherError.invalidParameter:
          return const Failure<WeatherCondition?, String>('パラメータが間違っています。');
        case YumemiWeatherError.unknown:
          return const Failure<WeatherCondition?, String>('予期せぬエラーが発生しました。');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            children: [
              const Spacer(),
              WeatherForecast(weatherCondition: weatherCondition),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            child: const Text('Close'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: fetchWeather,
                            child: const Text('Reload'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
