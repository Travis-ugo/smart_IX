import 'package:http/http.dart' as http;
import 'package:smart_ix/smart_ix/infrastructure/infrastructure.dart';

/// https://pub.dev/packages/http
/// the HTTP package is used to make api request.
class MetaAPiClient implements IMetaApiClient {
  MetaAPiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();
  final http.Client _httpClient;

  static const openWeatherApi = 'api.openweathermap.org';

  static const dataWeather = '/data/2.5/weather';

  /// getCurrentWeather uses location return by the getCurrentLocation
  /// function which uses the geolocator package to get current user location,
  /// and displays live weather information.
  @override
  Future<Weather> getCurrentWeather(
      {required double lat, required double lon}) async {
    /// https://openweathermap.org/api
    final queryParameters = {
      'lat': '$lat',
      'lon': '$lon',
      'appid': '718bee2be81541e7f7436b792aaf1540',
      'units': 'imperial',
    };
    final weatherRequest =
        Uri.https(openWeatherApi, dataWeather, queryParameters);

    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final jsonBody = jsonDecode(weatherResponse.body);

    return Weather.fromJson(jsonBody);
  }

  /// https://pub.dev/packages/geolocator
  /// getCurrentLocation uses the Geolocator package to get the current user location,
  /// returns the latitude and longitude
  @override
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    /// Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
