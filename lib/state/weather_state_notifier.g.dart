// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'weather_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weatherStateNotifierHash() =>
    r'3daf445cbb8897226ac7c0abdd3b133f9dd280db';

/// See also [WeatherStateNotifier].
@ProviderFor(WeatherStateNotifier)
final weatherStateNotifierProvider = AutoDisposeNotifierProvider<
    WeatherStateNotifier, WeatherForecast?>.internal(
  WeatherStateNotifier.new,
  name: r'weatherStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weatherStateNotifierHash,
  dependencies: <ProviderOrFamily>[weatherServiceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    weatherServiceProvider,
    ...?weatherServiceProvider.allTransitiveDependencies
  },
);

typedef _$WeatherStateNotifier = AutoDisposeNotifier<WeatherForecast?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
