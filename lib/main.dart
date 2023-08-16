import 'package:flutter/material.dart';
import 'package:flutter_training/repository/weather_repository.dart';
import 'package:flutter_training/view/weather_view/weather_page.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherPage(weather: WeatherRepository(YumemiWeather())),
    );
  }
}
