// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WeatherRequest _$$_WeatherRequestFromJson(Map<String, dynamic> json) =>
    _$_WeatherRequest(
      area: json['area'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$_WeatherRequestToJson(_$_WeatherRequest instance) =>
    <String, dynamic>{
      'area': instance.area,
      'date': instance.date.toIso8601String(),
    };
