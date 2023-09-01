import 'package:flutter/material.dart';
import 'package:flutter_training/model/weather_data.dart';
import 'package:flutter_training/model/weather_request.dart';
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
  WeatherData? weatherData;
  final service = WeatherService(YumemiWeather());

  void _onReloaded() {
    //fetchWeatherの結果がSuccessかFailureかで処理を分ける
    return switch (service
        .fetchWeather(WeatherRequest(area: 'Aichi', date: DateTime.now()))) {
      Success(value: final value) => setState(() => weatherData = value),
      Failure(exception: final error) => showDialog<void>(
          barrierDismissible: false,
          context: context,
          builder: (_) => _ErrorDialog(error),
        ),
    };
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
              WeatherForecast(weatherData: weatherData),
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
