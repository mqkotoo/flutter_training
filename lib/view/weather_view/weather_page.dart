import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Placeholder
              const AspectRatio(
                aspectRatio: 1,
                child: Placeholder(),
              ),
              const SizedBox(height: 16),
              //Temperature
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '** ℃',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '** ℃',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
