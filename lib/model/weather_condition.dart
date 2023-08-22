import 'package:flutter_svg/svg.dart';
import 'package:flutter_training/gen/assets.gen.dart';

enum WeatherCondition {
  sunny,
  cloudy,
  rainy,
}

extension WeatherSvgImage on WeatherCondition {
  SvgPicture get svgImage => switch (this) {
        WeatherCondition.sunny =>
          Assets.images.sunny.svg(semanticsLabel: 'Sunny image'),
        WeatherCondition.cloudy =>
          Assets.images.cloudy.svg(semanticsLabel: 'Cloudy image'),
        WeatherCondition.rainy =>
          Assets.images.rainy.svg(semanticsLabel: 'Rainy image')
      };
}
