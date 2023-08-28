import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/utils/api/result.dart';
import 'package:flutter_training/utils/extention/enum.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherService {
  WeatherService(this._client);

  final YumemiWeather _client;

  /// Get weather information
  /// If successful, the value is stored in [Success],
  /// if unsuccessful, the error message is stored in [Failure].

  Result<WeatherCondition?, String> fetchWeather() {
    try {
      final condition = _client.fetchThrowsWeather('Aichi');
      final weatherCondition = WeatherCondition.values.byNameOrNull(condition);
      if (weatherCondition == null) {
        return const Failure<WeatherCondition, String>('unknown');
      }
      return Success<WeatherCondition?, String>(weatherCondition);
    } on YumemiWeatherError catch (_) {
      return const Failure<WeatherCondition?, String>('予期せぬエラーが発生しました。');
    }
  }
}
