import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/state/weather_state_notifier.dart';

class WeatherForecastPanel extends ConsumerWidget {
  const WeatherForecastPanel({super.key});

  @visibleForTesting
  static final minTempKey = UniqueKey();
  @visibleForTesting
  static final maxTempKey = UniqueKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final weatherState = ref.watch(weatherStateNotifierProvider);
    return Column(
      children: [
        //Weather conditions
        AspectRatio(
          aspectRatio: 1,
          child: weatherState?.weatherCondition.svgImage ?? const Placeholder(),
        ),
        const SizedBox(height: 16),
        //Temperature
        Row(
          children: [
            Expanded(
              child: Text(
                '${weatherState?.minTemperature ?? '**'} ℃',
                textAlign: TextAlign.center,
                style: textTheme.labelLarge!.copyWith(
                  color: Colors.blue,
                ),
                key: minTempKey,
              ),
            ),
            Expanded(
              child: Text(
                '${weatherState?.maxTemperature ?? '**'} ℃',
                textAlign: TextAlign.center,
                style: textTheme.labelLarge!.copyWith(
                  color: Colors.red,
                ),
                key: maxTempKey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
