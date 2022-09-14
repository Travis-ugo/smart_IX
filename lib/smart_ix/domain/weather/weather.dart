import 'package:json_annotation/json_annotation.dart';
part 'weather.g.dart';
@JsonSerializable()
class Weather {
  final String name;

  final Temperature main;
  final WeatherInfo weather;

  const Weather({
    required this.name,
    required this.main,
    required this.weather,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}

@JsonSerializable()
class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({required this.description, required this.icon});
  factory WeatherInfo.fromJson(Map<String, dynamic> json) =>
      _$WeatherInfoFromJson(json);
}

@JsonSerializable()
class Temperature {
  final double temperature;

  Temperature({required this.temperature});

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);
}
