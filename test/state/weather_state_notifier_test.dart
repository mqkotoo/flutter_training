import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/model/weather_forecast.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/service/weather_service.dart';
import 'package:flutter_training/state/weather_state_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'weather_state_notifier_test.mocks.dart';

const jsonData = '''
        {
          "weather_condition": "cloudy",
          "max_temperature": 25, 
          "min_temperature": 7,
          "date": "2023-09-19T00:00:00.000"
        }
        ''';

const invalidJsonDataForFromJsonException = '''
        {
          "weather_condition": "thunder",
          "max_temperature": 25.0, 
          "min_temperature": 7,
          "date": "2023-09-19T00:00:00.000"
        }
        ''';

const invalidJsonDataForFormatException = '{invalid json data}';

final request = WeatherRequest(
  area: 'Nagoya',
  date: DateTime(2023, 9, 19),
);

@GenerateNiceMocks([MockSpec<YumemiWeather>()])
void main() {
  final mockClient = MockYumemiWeather();
  late final ProviderContainer container;

  setUp(() {
    //mockのYumemiWeatherでDIする
    container = ProviderContainer(
      overrides: [yumemiWeatherClientProvider.overrideWithValue(mockClient)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('success case: getWeather()', () {
    when(mockClient.fetchWeather(any)).thenReturn(jsonData);

    //　天気の取得処理を実行して、結果をstateに流す
    container
        .read(weatherStateNotifierProvider.notifier)
        .getWeather(request: request, onError: (error) {});

    final weatherState = container.read(weatherStateNotifierProvider);

    expect(weatherState, isNotNull);

    expect(
      weatherState,
      WeatherForecast(
        weatherCondition: WeatherCondition.cloudy,
        maxTemperature: 25,
        minTemperature: 7,
        date: DateTime(2023, 9, 19),
      ),
    );
  });

  group('failure case: getWeather()', () {
    test('unknown error case', () {
      when(mockClient.fetchWeather(any)).thenThrow(YumemiWeatherError.unknown);

      //　表示されるエラーメッセージを格納
      String? errorMessage;

      //　天気の取得処理を実行して、結果をstateに流す
      container.read(weatherStateNotifierProvider.notifier).getWeather(
            request: request,
            onError: (e) {
              errorMessage = e;
            },
          );

      final weatherState = container.read(weatherStateNotifierProvider);

      //取得はできてない
      expect(weatherState, null);
      expect(errorMessage, '予期せぬエラーが発生しました。');
    });

    test('invalidParameter error case', () {
      when(mockClient.fetchWeather(any))
          .thenThrow(YumemiWeatherError.invalidParameter);

      //　表示されるエラーメッセージを格納
      String? errorMessage;

      //　天気の取得処理を実行して、結果をstateに流す
      container.read(weatherStateNotifierProvider.notifier).getWeather(
            request: request,
            onError: (e) {
              errorMessage = e;
            },
          );

      final weatherState = container.read(weatherStateNotifierProvider);

      //取得はできてない
      expect(weatherState, null);
      expect(errorMessage, 'パラメータが有効ではありません。');
    });

    test('fromJson error case', () {
      when(mockClient.fetchWeather(any))
          .thenReturn(invalidJsonDataForFromJsonException);

      //　表示されるエラーメッセージを格納
      String? errorMessage;

      //　天気の取得処理を実行して、結果をstateに流す
      container.read(weatherStateNotifierProvider.notifier).getWeather(
            request: request,
            onError: (e) {
              errorMessage = e;
            },
          );

      final weatherState = container.read(weatherStateNotifierProvider);

      //取得はできてない
      expect(weatherState, null);
      expect(errorMessage, '不適切なデータを取得しました。');
    });

    test('jsonDecode() error case', () {
      when(mockClient.fetchWeather(any))
          .thenReturn(invalidJsonDataForFormatException);

      //　表示されるエラーメッセージを格納
      String? errorMessage;

      //　天気の取得処理を実行して、結果をstateに流す
      container.read(weatherStateNotifierProvider.notifier).getWeather(
            request: request,
            onError: (e) {
              errorMessage = e;
            },
          );

      final weatherState = container.read(weatherStateNotifierProvider);

      //取得はできてない
      expect(weatherState, null);
      expect(errorMessage, '不適切なデータを取得しました。');
    });
  });
}
