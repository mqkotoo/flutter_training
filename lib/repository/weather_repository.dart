import 'package:flutter/widgets.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherRepository {
  const WeatherRepository(this._client);

  final YumemiWeather _client;

  WeatherCondition? fetchWeather() {
    try {
      final condition = _client.fetchSimpleWeather();
      return WeatherCondition.values.byName(condition);
    } on Exception catch (e) {
      debugPrint('$e');
      return null;
    }
  }
}
