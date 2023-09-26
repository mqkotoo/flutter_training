import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/state/weather_state_notifier.dart';

class WeatherForecastPanel extends ConsumerWidget {
  const WeatherForecastPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final weatherData = ref.watch(weatherStateNotifierProvider);
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
