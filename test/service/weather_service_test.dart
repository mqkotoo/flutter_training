import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/model/weather_data.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/service/weather_service.dart';
import 'package:flutter_training/utils/api/result.dart';
import 'package:flutter_training/utils/provider/yumemi_weather_client.dart';
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

@GenerateNiceMocks([MockSpec<YumemiWeather>()])
void main() {
  final mockClient = MockYumemiWeather();
  when(mockClient.fetchWeather(any)).thenReturn(jsonData);

  final request = WeatherRequest(
    area: 'Nagoya',
    date: DateTime(2023, 9, 19),
  );

  late ProviderContainer container;

  setUpAll(() {
    //mockのYumemiWeatherでDIする
    container = ProviderContainer(
      overrides: [yumemiWeatherClientProvider.overrideWithValue(mockClient)],
    );
  });

  tearDownAll(() {
    container.dispose();
  });

  test('fetchWeather()', () {
    // when(mockClient.fetchWeather(any))
    //     .thenThrow(YumemiWeatherError.invalidParameter);

    final result = container.read(weatherServiceProvider).fetchWeather(request);

    expect(
      result,
      // WeatherData.fromJson(jsonDecode(jsonData) as Map<String, dynamic>),
      Success<WeatherData, String>(
        WeatherData.fromJson(
          jsonDecode(jsonData) as Map<String, dynamic>,
        ),
      ),
      // const Failure<WeatherData, String>('パラメータが有効ではありません。'),
    );
  });
}
