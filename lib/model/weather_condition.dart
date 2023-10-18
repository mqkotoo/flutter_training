import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_training/gen/assets.gen.dart';

enum WeatherCondition {
  sunny,
  cloudy,
  rainy,
}

extension WeatherSvgImage on WeatherCondition {
  @visibleForTesting
  static const sunnyLabel = 'Sunny image';
  @visibleForTesting
  static const cloudyLabel = 'Cloudy image';
  @visibleForTesting
  static const rainyLabel = 'Rainy image';

  SvgPicture get svgImage => switch (this) {
        WeatherCondition.sunny =>
          Assets.images.sunny.svg(semanticsLabel: sunnyLabel),
        WeatherCondition.cloudy =>
          Assets.images.cloudy.svg(semanticsLabel: cloudyLabel),
        WeatherCondition.rainy =>
          Assets.images.rainy.svg(semanticsLabel: rainyLabel)
      };
}
