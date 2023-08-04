import 'package:flutter/material.dart';
import 'package:flutter_training/view/weather_view/component/weather_forecast.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: WeatherForecast(),
        ),
      ),
    );
  }
}
