import 'package:flutter/widgets.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherRepository {
  WeatherRepository({required this.client});

  final YumemiWeather client;

  WeatherCondition? fetchWeather() {
    try {
      final condition = client.fetchSimpleWeather();
      return WeatherCondition.values.byName(condition);
    } on Exception catch (e) {
      debugPrint('$e');
      return null;
    }
  }
}
