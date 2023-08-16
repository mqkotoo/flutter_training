import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/utils/extention/enum.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherRepository {
  const WeatherRepository(this._client);

  final YumemiWeather _client;

  WeatherCondition? fetchWeather() {
    final condition = _client.fetchSimpleWeather();
    return WeatherCondition.values.byNameOrNull(condition);
  }
}
