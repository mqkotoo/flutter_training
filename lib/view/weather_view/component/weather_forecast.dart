import 'package:flutter/material.dart';
import 'package:flutter_training/model/weather_condition.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({super.key, required this.weatherCondition});

  final WeatherCondition? weatherCondition;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        //Placeholder
        AspectRatio(
          aspectRatio: 1,
          child: weatherCondition == null
              ? const Placeholder()
              : weatherCondition!.svgImage,
        ),
        const SizedBox(height: 16),
        //Temperature
        Row(
          children: [
            Expanded(
              child: Text(
                '** ℃',
                textAlign: TextAlign.center,
                style: textTheme.labelLarge!.copyWith(
                  color: Colors.blue,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '** ℃',
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
