import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/model/weather_forecast.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/service/weather_service.dart';
import 'package:flutter_training/utils/api/result.dart';
import 'package:flutter_training/utils/error/error_message.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import '../utils/dummy_data.dart';
import 'weather_service_test.mocks.dart';

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
    when(mockClient.fetchWeather(any)).thenReturn(validJsonData);

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
          date: DateTime(2023, 9, 19, 10, 24, 31, 877),
        ),
      ),
    );
  });

  group('failure case', () {
    test('invalidParameter error is thrown', () {
      when(mockClient.fetchWeather(any))
          .thenThrow(YumemiWeatherError.invalidParameter);

      final result =
          container.read(weatherServiceProvider).fetchWeather(request);

      expect(
        result,
        isA<Failure<WeatherForecast, String>>().having(
          (error) => error.exception,
          'error message',
          ErrorMessage.invalidParameter,
        ),
      );
    });

    test('unknown error is thrown', () {
      when(mockClient.fetchWeather(any)).thenThrow(YumemiWeatherError.unknown);

      final result =
          container.read(weatherServiceProvider).fetchWeather(request);

      expect(
        result,
        isA<Failure<WeatherForecast, String>>().having(
          (error) => error.exception,
          'error message',
          ErrorMessage.unknown,
        ),
      );
    });
  });
}
