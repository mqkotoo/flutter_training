import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/model/weather_request.dart';

void main() {
  test('success case: encode WeatherRequest', () {
    final request = WeatherRequest(
      area: 'Nagoya',
      date: DateTime(2023, 9, 19),
    );

    final requestJson = jsonEncode(request);

    expect(
      requestJson,
      '{"area":"Nagoya","date":"2023-09-19T00:00:00.000"}',
    );
  });
}
