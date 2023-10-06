import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/model/weather_forecast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/dummy_data.dart';

void main() {
  test('success case: fromJson', () {
    final data = jsonDecode(validJsonData) as Map<String, dynamic>;
    final result = WeatherForecast.fromJson(data);

    expect(result.weatherCondition, WeatherCondition.cloudy);
    expect(result.maxTemperature, 25);
    expect(result.minTemperature, 7);
    expect(
      result.date,
      DateTime(2023, 9, 19, 10, 24, 31, 877),
    );
  });

  group('failure case: fromJon', () {
    test('non-exist weather', () {
      const jsonData = '''
        {
          "weather_condition": "thunder",
          "max_temperature": 25, 
          "min_temperature": 7,
          "date": "2023-09-19 10:24:31.877"
        }
        ''';

      final data = jsonDecode(jsonData) as Map<String, dynamic>;

      expect(
        () => WeatherForecast.fromJson(data),
        throwsA(isA<CheckedFromJsonException>()),
        reason: 'thunder does not exist in WeatherCondition',
      );
    });

    test('jsonData has wrong key', () {
      const jsonData = '''
        {
          "weather_condition_wrong_key": "cloudy",
          "max_temperature": 25, 
          "min_temperature": 7,
          "date": "2023-09-19 10:24:31.877"
        }
        ''';

      final data = jsonDecode(jsonData) as Map<String, dynamic>;

      expect(
        () => WeatherForecast.fromJson(data),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });

    test('unexpected type of value', () {
      const jsonData = '''
        {
          "weather_condition": 42.195,
          "max_temperature": 25, 
          "min_temperature": 7,
          "date": "2023-09-19 10:24:31.877"
        }
        ''';

      final data = jsonDecode(jsonData) as Map<String, dynamic>;

      expect(
        () => WeatherForecast.fromJson(data),
        throwsA(isA<CheckedFromJsonException>()),
        reason: 'weather_condition expect <WeatherCondition>',
      );
    });

    test('required property is missing', () {
      const jsonData = '''
        {
          "weather_condition": "cloudy",
          "max_temperature": 25, 
          "date": "2023-09-19 10:24:31.877"
        }
        ''';

      final data = jsonDecode(jsonData) as Map<String, dynamic>;

      expect(
        () => WeatherForecast.fromJson(data),
        throwsA(isA<CheckedFromJsonException>()),
        reason: 'min_temperature is required',
      );
    });
  });

  // jsonのデコードのテストも以下に書く
  test('jsonDecode() success case', () {
    const jsonData = '''
        {
          "weather_condition": "cloudy",
          "max_temperature": 25, 
          "min_temperature": 7,
          "date": "2023-09-19 10:24:31.877"
        }
        ''';

    final decodedData = jsonDecode(jsonData) as Map<String, dynamic>;

    expect(decodedData, isA<Map<String, dynamic>>());
    expect(decodedData['weather_condition'], 'cloudy');
    expect(decodedData['max_temperature'], 25);
    expect(decodedData['min_temperature'], 7);
    expect(decodedData['date'], '2023-09-19 10:24:31.877');
  });

  test('jsonDecode() failure case', () {
    const jsonData = '{invalid json data}';

    expect(
      () => jsonDecode(jsonData) as Map<String, dynamic>,
      throwsA(isA<FormatException>()),
    );
  });
}
