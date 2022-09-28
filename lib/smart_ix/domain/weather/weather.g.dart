// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      name: json['name'] as String,
      tempInfo: Temperature.fromJson(json['tempInfo'] as Map<String, dynamic>),
      weather: WeatherInfo.fromJson(json['weather'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'name': instance.name,
      'tempInfo': instance.tempInfo,
      'weather': instance.weather,
    };

WeatherInfo _$WeatherInfoFromJson(Map<String, dynamic> json) => WeatherInfo(
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherInfoToJson(WeatherInfo instance) =>
    <String, dynamic>{
      'description': instance.description,
      'icon': instance.icon,
    };

Temperature _$TemperatureFromJson(Map<String, dynamic> json) => Temperature(
      temp: (json['temp'] as num).toDouble(),
    );

Map<String, dynamic> _$TemperatureToJson(Temperature instance) =>
    <String, dynamic>{
      'temp': instance.temp,
    };
