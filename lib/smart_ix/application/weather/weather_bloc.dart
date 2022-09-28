// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_ix/smart_ix/infrastructure/infrastructure.dart';

import 'package:smart_ix/smart_ix/infrastructure/weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final MetaAPiClient metaAPiClient;

  WeatherBloc({
    required this.metaAPiClient,
  }) : super(WeatherApiLoadingState()) {
    on<LoadWeatherEvent>((event, emit) async {
      try {
        final locationResponse = await metaAPiClient.getCurrentLocation();
        final currentWeatherData = await metaAPiClient.getCurrentWeather(
            lat: locationResponse.latitude, lon: locationResponse.longitude);

        emit(
          WeatherApiLoadedState(
            city: currentWeatherData.name,
            temperature: currentWeatherData.tempInfo,
            weatherInfo: currentWeatherData.weather,
          ),
        );
      } catch (e) {}
    });
  }
}
