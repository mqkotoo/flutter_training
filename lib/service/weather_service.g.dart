// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'weather_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$yumemiWeatherClientHash() =>
    r'e40a0489f105c552873993d37c21849839ab751f';

/// See also [yumemiWeatherClient].
@ProviderFor(yumemiWeatherClient)
final yumemiWeatherClientProvider = AutoDisposeProvider<YumemiWeather>.internal(
  yumemiWeatherClient,
  name: r'yumemiWeatherClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$yumemiWeatherClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef YumemiWeatherClientRef = AutoDisposeProviderRef<YumemiWeather>;

String _$weatherServiceHash() => r'41a00cbad069db0e4e14ae437ab2772c05c9916c';

/// See also [weatherService].
@ProviderFor(weatherService)
final weatherServiceProvider = AutoDisposeProvider<WeatherService>.internal(
  weatherService,
  name: r'weatherServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weatherServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WeatherServiceRef = AutoDisposeProviderRef<WeatherService>;
String _$loadingStateNotifierHash() =>
    r'6c22092104ce7a9a407ef4f8ea50dd23369cd34f';

/// See also [LoadingStateNotifier].
@ProviderFor(LoadingStateNotifier)
final loadingStateNotifierProvider =
    AutoDisposeNotifierProvider<LoadingStateNotifier, bool>.internal(
  LoadingStateNotifier.new,
  name: r'loadingStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loadingStateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LoadingStateNotifier = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
