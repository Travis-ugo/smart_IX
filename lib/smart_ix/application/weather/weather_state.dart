part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherApiLoadingState extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherApiLoadedState extends WeatherState {
  final Temperature temperature;
  final WeatherInfo weatherInfo;
  final String city;
  const WeatherApiLoadedState({
    required this.temperature,
    required this.weatherInfo,
    required this.city,
  });

  @override
  List<Object> get props => [temperature, weatherInfo, city];
}
