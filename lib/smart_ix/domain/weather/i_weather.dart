import 'package:geolocator/geolocator.dart';

import 'weather.dart';

/// MetaApiClient repository implements the abstract methods
abstract class IMetaApiClient {
  Future<Weather> getCurrentWeather({required double lat, required double lon});

  Future<Position> getCurrentLocation();
}
