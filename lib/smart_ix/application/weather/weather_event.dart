part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class LoadWeatherEvent extends WeatherEvent {
  const LoadWeatherEvent();
  @override
  List<Object> get props => [];
}
