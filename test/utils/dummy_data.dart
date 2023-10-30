import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/model/weather_forecast.dart';
import 'package:flutter_training/utils/api/result.dart';

const validJsonData = '''
        {
          "weather_condition": "cloudy",
          "max_temperature": 25, 
          "min_temperature": 7,
          "date": "2023-09-19 10:24:31.877"
        }
        ''';

final sunnyWeatherData = Success<WeatherForecast, String>(
  WeatherForecast(
    weatherCondition: WeatherCondition.sunny,
    maxTemperature: 30,
    minTemperature: 0,
    date: DateTime(2023, 9, 19, 10, 24, 31, 877),
  ),
);

final cloudyWeatherData = Success<WeatherForecast, String>(
  WeatherForecast(
    weatherCondition: WeatherCondition.cloudy,
    maxTemperature: 25,
    minTemperature: 7,
    date: DateTime(2023, 9, 19, 10, 24, 31, 877),
  ),
);

final rainyWeatherData = Success<WeatherForecast, String>(
  WeatherForecast(
    weatherCondition: WeatherCondition.rainy,
    maxTemperature: 44,
    minTemperature: -22,
    date: DateTime(2023, 9, 19, 10, 24, 31, 877),
  ),
);

const invalidJsonDataForCheckedFromJsonException = '''
        {
          "weather_condition": "thunder",
          "max_temperature": 25.0, 
          "min_temperature": 7,
          "date": "2023-09-19T00:00:00.000"
        }
        ''';

const invalidJsonDataForFormatException = '{invalid json data}';
