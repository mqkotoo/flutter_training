import 'package:flutter/material.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/model/weather_data.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({super.key, required this.weatherData});

  final WeatherData? weatherData;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        //Weather conditions
        AspectRatio(
          aspectRatio: 1,
          child: weatherData?.weatherCondition.svgImage ?? const Placeholder(),
        ),
        const SizedBox(height: 16),
        //Temperature
        Row(
          children: [
            Expanded(
              child: Text(
                '${weatherData?.minTemperature ?? '**'} ℃',
                textAlign: TextAlign.center,
                style: textTheme.labelLarge!.copyWith(
                  color: Colors.blue,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '${weatherData?.maxTemperature ?? '**'} ℃',
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
