import 'package:flutter/material.dart';
import 'package:flutter_training/utils/mixin/after_display_mixin.dart';
import 'package:flutter_training/view/weather_view/weather_page.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> with AfterDisplayMixin {
  Future<void> _toWeatherPage() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) {
      return;
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const WeatherPage(),
      ),
    );
    //   WeatherPageから帰ってくるのを待つ
    await _toWeatherPage();
  }

  @override
  void afterDisplay() {
    _toWeatherPage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green);
  }
}
