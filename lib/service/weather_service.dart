import 'dart:convert';

import 'package:flutter_training/model/weather_data.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/utils/api/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherService {
  WeatherService(this._client);

  final YumemiWeather _client;

  /// Get weather information
  /// If successful, the value is stored in [Success],
  /// if unsuccessful, the error message is stored in [Failure].

  Result<WeatherData, String> fetchWeather(WeatherRequest request) {
    try {
      final jsonData = jsonEncode(request);
      final resultJson = _client.fetchWeather(jsonData);
      final weatherData = jsonDecode(resultJson) as Map<String, dynamic>;
      final result = WeatherData.fromJson(weatherData);
      return Success<WeatherData, String>(result);
    } on YumemiWeatherError catch (e) {
      return switch (e) {
        YumemiWeatherError.invalidParameter =>
          const Failure<WeatherData, String>('パラメータが有効ではありません。'),
        YumemiWeatherError.unknown =>
          const Failure<WeatherData, String>('予期せぬエラーが発生しました。')
      };
    } on CheckedFromJsonException catch (_) {
      return const Failure<WeatherData, String>('不適切なデータを取得しました。');
    } on FormatException catch (_) {
      return const Failure<WeatherData, String>('jsonのデコードに失敗しました。');
    }
  }
}
