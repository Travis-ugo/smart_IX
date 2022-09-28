import 'package:json_annotation/json_annotation.dart';
part 'weather.g.dart';

@JsonSerializable()
class Weather {
  final String name;

  final Temperature tempInfo;
  final WeatherInfo weather;

  const Weather({
    required this.name,
    required this.tempInfo,
    required this.weather,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final tempInfo = Temperature.fromJson(
      json['main'],
    );

    final weather = WeatherInfo.fromJson(json['weather'][0]);
    return Weather(
      name: cityName,
      tempInfo: tempInfo,
      weather: weather,
    );
  }
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
  final double temp;

  Temperature({required this.temp});

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);
}
