// Mocks generated by Mockito 5.4.2 from annotations
// in flutter_training/test/service/weather_service_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mockito/mockito.dart' as _i1;
import 'package:yumemi_weather/src/yumemi_weather_base.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [YumemiWeather].
///
/// See the documentation for Mockito's code generation for more information.
class MockYumemiWeather extends _i1.Mock implements _i2.YumemiWeather {
  @override
  String fetchSimpleWeather() => (super.noSuchMethod(
        Invocation.method(
          #fetchSimpleWeather,
          [],
        ),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  String fetchThrowsWeather(String? area) => (super.noSuchMethod(
        Invocation.method(
          #fetchThrowsWeather,
          [area],
        ),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  String fetchWeather(String? jsonString) => (super.noSuchMethod(
        Invocation.method(
          #fetchWeather,
          [jsonString],
        ),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  String syncFetchWeather(String? jsonString) => (super.noSuchMethod(
        Invocation.method(
          #syncFetchWeather,
          [jsonString],
        ),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
}
