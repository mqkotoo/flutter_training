// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:flutter_training/model/weather_forecast.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/service/weather_service.dart';
import 'package:flutter_training/state/loading_state_notifier.dart';
import 'package:flutter_training/utils/api/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_state_notifier.g.dart';

@riverpod
class WeatherStateNotifier extends _$WeatherStateNotifier {
  @override
  WeatherForecast? build() => null;

  Future<void> getWeather({
    required WeatherRequest request,
    required void Function(String error) onError,
  }) async {
    ref.read(loadingStateNotifierProvider.notifier).show();
    final result = await ref.read(weatherServiceProvider).fetchWeather(request);
    ref.read(loadingStateNotifierProvider.notifier).hide();
    return switch (result) {
      Success(value: final value) => state = value,
      Failure(exception: final error) => onError.call(error),
    };
  }
}
