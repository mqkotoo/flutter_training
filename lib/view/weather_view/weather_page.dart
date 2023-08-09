import 'package:flutter/material.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/repository/weather_repository.dart';
import 'package:flutter_training/view/weather_view/component/weather_forecast.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key, required this.weather});

  final WeatherRepository weather;

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

WeatherCondition? weatherCondition;

class _WeatherPageState extends State<WeatherPage> {
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
                            child: const Text('Reload'),
                            onPressed: () {
                              setState(() {
                                weatherCondition =
                                    widget.weather.fetchWeather();
                              });
                            },
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
