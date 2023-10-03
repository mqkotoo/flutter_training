import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/model/weather_forecast.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/service/weather_service.dart';
import 'package:flutter_training/utils/api/result.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'weather_service_test.mocks.dart';

const jsonData = '''
        {
          "weather_condition": "cloudy",
          "max_temperature": 25, 
          "min_temperature": 7,
          "date": "2023-09-19T00:00:00.000"
        }
        ''';

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

  test('success case', () {
    when(mockClient.fetchWeather(any)).thenReturn(jsonData);

    final result = container.read(weatherServiceProvider).fetchWeather(request);

    expect(
      result,
      isA<Success<WeatherForecast, String>>().having(
        (success) => success.value,
        'success weather data',
        WeatherForecast(
          weatherCondition: WeatherCondition.cloudy,
          maxTemperature: 25,
          minTemperature: 7,
          date: DateTime(2023, 9, 19),
        ),
      ),
    );
  });

  group('failure case', () {
    test('invalidParameter error', () {
      when(mockClient.fetchWeather(any))
          .thenThrow(YumemiWeatherError.invalidParameter);

      final result =
          container.read(weatherServiceProvider).fetchWeather(request);

      expect(
        result,
        isA<Failure<WeatherForecast, String>>().having(
          (error) => error.exception,
          'error message',
          'パラメータが有効ではありません。',
        ),
      );
    });

    test('unknown error', () {
      when(mockClient.fetchWeather(any)).thenThrow(YumemiWeatherError.unknown);

      final result =
          container.read(weatherServiceProvider).fetchWeather(request);

      expect(
        result,
        isA<Failure<WeatherForecast, String>>().having(
          (error) => error.exception,
          'error message',
          '予期せぬエラーが発生しました。',
        ),
      );
    });
  });
}
