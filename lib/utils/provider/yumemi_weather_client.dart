import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'yumemi_weather_client.g.dart';

@riverpod
YumemiWeather yumemiWeatherClient(YumemiWeatherClientRef ref) {
  return YumemiWeather();
}
