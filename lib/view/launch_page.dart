import 'package:flutter/material.dart';
import 'package:flutter_training/view/weather_view/weather_page.dart';

mixin AfterDisplay<T extends StatefulWidget> on State<T> {
  void afterDisplay();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then((_) {
      afterDisplay();
    });
  }
}

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> with AfterDisplay {
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
