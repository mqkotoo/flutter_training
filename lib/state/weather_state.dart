import 'package:flutter_training/model/weather_data.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/service/weather_service.dart';
import 'package:flutter_training/utils/api/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_state.g.dart';

@riverpod
class WeatherState extends _$WeatherState {
  @override
  WeatherData? build() => null;

  void getWeather({
    required WeatherRequest request,
    required void Function(String error) onError,
  }) {
    return switch (ref.read(weatherServiceProvider).fetchWeather(request)) {
      Success(value: final value) => state = value,
      Failure(exception: final error) => onError.call(error),
    };
  }
}
