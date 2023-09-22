import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/state/weather_state.dart';
import 'package:flutter_training/view/weather_view/component/weather_forecast.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onReloaded(WeatherRequest request) {
      ref.read(weatherStateNotifierProvider.notifier).getWeather(
            request: request,
            onError: (errorMessage) => showDialog<void>(
              barrierDismissible: false,
              context: context,
              builder: (_) => _ErrorDialog(errorMessage),
            ),
          );
    }

    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            children: [
              const Spacer(),
              const WeatherForecast(),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            child: const Text('Close'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              onReloaded(
                                WeatherRequest(
                                  area: 'Nagoya',
                                  date: DateTime.now(),
                                ),
                              );
                            },
                            child: const Text('Reload'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorDialog extends StatelessWidget {
  const _ErrorDialog(this.errorMessage);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('エラー'),
      content: Text(errorMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        )
      ],
    );
  }
}
