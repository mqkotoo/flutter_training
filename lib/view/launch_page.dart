import 'package:flutter/material.dart';
import 'package:flutter_training/repository/weather_repository.dart';
import 'package:flutter_training/view/weather_view/weather_page.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  Future<void> _toWeatherPage() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) {
      return;
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => WeatherPage(
          weather: WeatherRepository(client: YumemiWeather()),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then((_) => _toWeatherPage());
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green);
  }
}
