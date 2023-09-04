import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/utils/extention/enum.dart';

class WeatherData {
  const WeatherData({
    required this.weatherCondition,
    required this.maxTemperature,
    required this.minTemperature,
    required this.date,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final weatherCondition = WeatherCondition.values
        .byNameOrNull(json['weather_condition'].toString());
    if (weatherCondition == null) {
      throw const FormatException('Invalid value for [WeatherCondition].');
    }

    final maxTemperature = int.parse(json['max_temperature'].toString());

    final minTemperature = int.parse(json['min_temperature'].toString());

    final date = json['date']?.toString();
    if (date == null) {
      throw const FormatException('Value for "date" is missing or not valid.');
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
