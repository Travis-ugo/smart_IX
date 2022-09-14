import 'package:http/http.dart' as http;
import 'package:smart_ix/smart_ix/infrastructure/infrastructure.dart';

class MetaAPiClient implements IMetaApiClient {
  MetaAPiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();
  final http.Client _httpClient;

  static const openWeatherApi = 'api.openweathermap.org';

  static const data_weather = '/data/2.5/weather';

  final queryParameters = {
    'q': 'asaba',
    'appid': '718bee2be81541e7f7436b792aaf1540',
    'units': 'imperial',
  };
  @override
  Future<Weather> getCurrentWeather({required String cityName}) async {
    print('get weather called');
    final weatherRequestUri =
        Uri.https(openWeatherApi, data_weather, queryParameters);
    final weatherResponse = await _httpClient.get(weatherRequestUri);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final jsonBody = jsonDecode(weatherResponse.body) as Map<String, dynamic>;
    print(jsonBody);
    if (jsonBody.isEmpty) {
      throw WeatherNotFoundFailure();
    }
    // research about this
    final weatherResponseBody = jsonBody['consolidated_weather'] as List;

    if (weatherResponseBody.isEmpty) {
      throw WeatherNotFoundFailure();
    }
    print(weatherResponseBody.first);
    return Weather.fromJson(weatherResponseBody.first as Map<String, dynamic>);
  }

  @override
  Future<Position> getCurrentLocation() async {
    print('get position called');
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
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

    print(
        'Current position is latitude${position.latitude} , and longitude${position.longitude}');
    return position;
  }
}
