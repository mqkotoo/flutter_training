import 'package:flutter/material.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/model/weather_data.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({super.key, required this.weatherData});

  final WeatherData? weatherData;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final weatherData = this.weatherData;
    return Column(
      children: [
        //Placeholder
        AspectRatio(
          aspectRatio: 1,
          child: weatherData == null
              ? const Placeholder()
              : weatherData.weatherCondition.svgImage,
        ),
        const SizedBox(height: 16),
        //Temperature
        Row(
          children: [
            Expanded(
              child: Text(
                weatherData == null
                    ? '** ℃'
                    : '${weatherData.minTemperature} ℃',
                textAlign: TextAlign.center,
                style: textTheme.labelLarge!.copyWith(
                  color: Colors.blue,
                ),
              ),
            ),
            Expanded(
              child: Text(
                weatherData == null
                    ? '** ℃'
                    : '${weatherData.maxTemperature} ℃',
                textAlign: TextAlign.center,
                style: textTheme.labelLarge!.copyWith(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
