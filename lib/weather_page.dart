import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: AspectRatio(
            aspectRatio: 1,
            child: Placeholder(),
          ),
        ),
      ),
    );
  }
}
