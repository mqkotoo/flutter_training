// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'weather_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$yumemiWeatherClientHash() =>
    r'38eba946f0af47492e5740938eeccfd96ff4600a';

/// See also [yumemiWeatherClient].
@ProviderFor(yumemiWeatherClient)
final yumemiWeatherClientProvider = AutoDisposeProvider<YumemiWeather>.internal(
  yumemiWeatherClient,
  name: r'yumemiWeatherClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$yumemiWeatherClientHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

typedef YumemiWeatherClientRef = AutoDisposeProviderRef<YumemiWeather>;

String _$weatherServiceHash() => r'0788d6f27a695455d6dcf3b0b46f0df60ce1dc7d';

/// See also [weatherService].
@ProviderFor(weatherService)
final weatherServiceProvider = AutoDisposeProvider<WeatherService>.internal(
  weatherService,
  name: r'weatherServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weatherServiceHash,
  dependencies: <ProviderOrFamily>[yumemiWeatherClientProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    yumemiWeatherClientProvider,
    ...?yumemiWeatherClientProvider.allTransitiveDependencies
  },
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
