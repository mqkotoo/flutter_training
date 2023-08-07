import 'package:flutter_training/model/weather_condition.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherRepository {
  WeatherRepository({required this.client});

  final YumemiWeather client;

  WeatherCondition fetchWeather() {
    final condition = client.fetchSimpleWeather();
    return WeatherCondition.values.byName(condition);
  }
}
