import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/model/weather_forecast.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/service/weather_service.dart';
import 'package:flutter_training/state/weather_state_notifier.dart';
import 'package:flutter_training/utils/error/error_message.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import '../utils/dummy_data.dart';
import 'weather_state_notifier_test.mocks.dart';

final request = WeatherRequest(
  area: 'Nagoya',
  date: DateTime(2023, 9, 19),
);

@GenerateNiceMocks([MockSpec<YumemiWeather>()])
void main() {
  final mockClient = MockYumemiWeather();
  late ProviderContainer container;

  setUp(() {
    //mockのYumemiWeatherでDIする
    container = ProviderContainer(
      overrides: [yumemiWeatherClientProvider.overrideWithValue(mockClient)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('success case: getWeather()', () async {
    when(mockClient.syncFetchWeather(any)).thenReturn(validJsonData);

    // 以下でgetWeather()してからweatherStateを読み取ってもkeepAliveじゃないので破棄される
    // よってcontainer.listenを使ってwatchのように天気を監視する
    // ref: https://riverpod.dev/ja/docs/essentials/testing#:~:text=notified%20of%20changes.-,%E6%B3%A8%E6%84%8F,-Be%20careful%20when
    final weatherStateWatcher =
        container.listen(weatherStateNotifierProvider, (_, __) {});

    //　天気の取得処理を実行して、結果をstateに流す
    await container
        .read(weatherStateNotifierProvider.notifier)
        .getWeather(request: request, onError: (error) {});

    expect(
      weatherStateWatcher.read(),
      WeatherForecast(
        weatherCondition: WeatherCondition.cloudy,
        maxTemperature: 25,
        minTemperature: 7,
        date: DateTime(2023, 9, 19, 10, 24, 31, 877),
      ),
    );
  });

  group('failure case: getWeather()', () {
    test('an unknown error is thrown', () async {
      when(mockClient.syncFetchWeather(any))
          .thenThrow(YumemiWeatherError.unknown);

      final weatherStateWatcher =
          container.listen(weatherStateNotifierProvider, (_, __) {});

      //　表示されるエラーメッセージを格納
      String? errorMessage;

      //　天気の取得処理を実行して、結果をstateに流す
      await container.read(weatherStateNotifierProvider.notifier).getWeather(
            request: request,
            onError: (e) {
              errorMessage = e;
            },
          );

      // 失敗なので天気情報は取得できていないはず
      expect(weatherStateWatcher.read(), null);
      expect(errorMessage, ErrorMessage.unknown);
    });

    test('invalidParameter error is thrown', () async {
      when(mockClient.syncFetchWeather(any))
          .thenThrow(YumemiWeatherError.invalidParameter);

      final weatherStateWatcher =
          container.listen(weatherStateNotifierProvider, (_, __) {});

      //　表示されるエラーメッセージを格納
      String? errorMessage;

      //　天気の取得処理を実行して、結果をstateに流す
      await container.read(weatherStateNotifierProvider.notifier).getWeather(
            request: request,
            onError: (e) {
              errorMessage = e;
            },
          );

      // 失敗なので天気情報は取得できていないはず
      expect(weatherStateWatcher.read(), null);
      expect(errorMessage, ErrorMessage.invalidParameter);
    });

    test('fromJson error case: CheckedFromJsonException should be thrown.',
        () async {
      when(mockClient.syncFetchWeather(any))
          .thenReturn(invalidJsonDataForCheckedFromJsonException);

      final weatherStateWatcher =
          container.listen(weatherStateNotifierProvider, (_, __) {});

      //　表示されるエラーメッセージを格納
      String? errorMessage;

      //　天気の取得処理を実行して、結果をstateに流す
      await container.read(weatherStateNotifierProvider.notifier).getWeather(
            request: request,
            onError: (e) {
              errorMessage = e;
            },
          );

      // 失敗なので天気情報は取得できていないはず
      expect(weatherStateWatcher.read(), null);
      expect(errorMessage, ErrorMessage.receiveInvalidData);
    });

    test('received data is not in JSON format', () async {
      when(mockClient.syncFetchWeather(any))
          .thenReturn(invalidJsonDataForFormatException);

      final weatherStateWatcher =
          container.listen(weatherStateNotifierProvider, (_, __) {});

      //　表示されるエラーメッセージを格納
      String? errorMessage;

      //　天気の取得処理を実行して、結果をstateに流す
      await container.read(weatherStateNotifierProvider.notifier).getWeather(
            request: request,
            onError: (e) {
              errorMessage = e;
            },
          );

      // 失敗なので天気情報は取得できていないはず
      expect(weatherStateWatcher.read(), null);
      expect(errorMessage, ErrorMessage.receiveInvalidData);
    });
  });
}
