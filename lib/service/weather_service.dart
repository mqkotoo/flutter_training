import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_training/model/weather_forecast.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/utils/api/result.dart';
import 'package:flutter_training/utils/error/error_message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_service.g.dart';

@riverpod
YumemiWeather yumemiWeatherClient(YumemiWeatherClientRef ref) {
  return YumemiWeather();
}

@riverpod
WeatherService weatherService(WeatherServiceRef ref) {
  return WeatherService(ref.watch(yumemiWeatherClientProvider), ref);
}

@riverpod
class LoadingStateNotifier extends _$LoadingStateNotifier {
  @override
  bool build() => false;

  void show() => state = true;

  void hide() => state = false;
}

class WeatherService {
  WeatherService(this._client, this._ref);

  final YumemiWeather _client;
  final AutoDisposeProviderRef<WeatherService> _ref;

  /// Get weather information
  ///
  /// If successful, the value is stored in [Success],
  /// if unsuccessful, the error message is stored in [Failure].

  Future<Result<WeatherForecast, String>> fetchWeather(
    WeatherRequest request,
  ) async {
    try {
      _ref.read(loadingStateNotifierProvider.notifier).show();
      final jsonData = jsonEncode(request);
      final resultJson = await compute(_client.syncFetchWeather, jsonData);
      final weatherData = jsonDecode(resultJson) as Map<String, dynamic>;
      final result = WeatherForecast.fromJson(weatherData);
      _ref.read(loadingStateNotifierProvider.notifier).hide();
      return Success<WeatherForecast, String>(result);
    } on YumemiWeatherError catch (e) {
      _ref.read(loadingStateNotifierProvider.notifier).hide();
      return switch (e) {
        YumemiWeatherError.invalidParameter =>
          const Failure<WeatherForecast, String>(ErrorMessage.invalidParameter),
        YumemiWeatherError.unknown =>
          const Failure<WeatherForecast, String>(ErrorMessage.unknown)
      };
    } on CheckedFromJsonException catch (_) {
      _ref.read(loadingStateNotifierProvider.notifier).hide();
      return const Failure<WeatherForecast, String>(
        ErrorMessage.receiveInvalidData,
      );
    } on FormatException catch (_) {
      _ref.read(loadingStateNotifierProvider.notifier).hide();
      return const Failure<WeatherForecast, String>(
        ErrorMessage.receiveInvalidData,
      );
    }
  }
}
