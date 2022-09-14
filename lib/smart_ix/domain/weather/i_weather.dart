import 'package:geolocator/geolocator.dart';

import 'weather.dart';

abstract class IMetaApiClient {
  Future<Weather> getCurrentWeather({required String cityName});
  Future<Position> getCurrentLocation();
}
