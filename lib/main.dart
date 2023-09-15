import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/utils/provider/yumemi_weather_client.dart';
import 'package:flutter_training/view/launch_page.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      overrides: [
        //YumemiWeatherクライアントを注入
        yumemiWeatherClientProvider.overrideWithValue(
          YumemiWeather(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LaunchPage(),
    );
  }
}
