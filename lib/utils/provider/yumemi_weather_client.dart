import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'yumemi_weather_client.g.dart';

//初回に上書きしてキャッシュして使うので、直接アクセスはできないようにする
@riverpod
YumemiWeather yumemiWeatherClient(YumemiWeatherClientRef ref) {
  throw UnimplementedError();
}
