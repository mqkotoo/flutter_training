import 'package:flutter/material.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/utils/extention/enum.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherData {
  const WeatherData({
    required this.weatherCondition,
    required this.maxTemperature,
    required this.minTemperature,
    required this.date,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    Never throwFormatException(String message) =>
        throw FormatException(message);

    Never throwInvalidError() =>
        throw YumemiWeatherError.invalidParameter as Exception;

    final weatherCondition = WeatherCondition.values
        .byNameOrNull(json['weather_condition'].toString());
    if (weatherCondition == null) {
      debugPrint('Invalid value for [WeatherCondition].');
      throwInvalidError();
    }

    final maxTemperature = int.tryParse(json['max_temperature'].toString());
    if (maxTemperature == null) {
      throwFormatException('max_temperature must be a valid int.');
    }

    final minTemperature = int.tryParse(json['min_temperature'].toString());
    if (minTemperature == null) {
      throwFormatException('max_temperature must be a valid int.');
    }

    final date = json['date']?.toString();
    if (date == null) {
      debugPrint('Value for "date" is missing or not valid.');
      throwInvalidError();
    }

    return WeatherData(
      weatherCondition: weatherCondition,
      maxTemperature: maxTemperature,
      minTemperature: minTemperature,
      date: DateTime.parse(date),
    );
  }

  final WeatherCondition weatherCondition;
  final int maxTemperature;
  final int minTemperature;
  final DateTime date;
}
