import 'package:flutter/material.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/service/weather_service.dart';
import 'package:flutter_training/utils/api/result.dart';
import 'package:flutter_training/view/weather_view/component/weather_forecast.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherCondition? weatherCondition;
  final service = WeatherService(YumemiWeather());

  void _onReloaded() {
    switch (service.fetchWeather()) {
      case Success(value: final value):
        setState(() => weatherCondition = value);
        break;
      case Failure(exception: final error):
        showDialog<void>(
          context: context,
          builder: (_) => _ErrorDialog(error),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            children: [
              const Spacer(),
              WeatherForecast(weatherCondition: weatherCondition),
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
                            onPressed: _onReloaded,
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
