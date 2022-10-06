import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:smart_ix/smart_ix/infrastructure/infrastructure.dart';
import 'package:smart_ix/smart_ix/infrastructure/weather/weather.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockHttpResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

const openWeatherApi = 'api.openweathermap.org';

const data_weather = '/data/2.5/weather';

const queryParameters = {
  'q': 'asaba',
  'appid': '718bee2be81541e7f7436b792aaf1540',
  'units': 'imperial',
};

void main() {
  group('MetaAPiClient', () {
    late http.Client httpClient;
    late MetaAPiClient metaApiClient;
    late MockHttpResponse mockHttpResponse;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      metaApiClient = MetaAPiClient(httpClient: httpClient);
      mockHttpResponse = MockHttpResponse();
    });

    group('getWeather', () {
      const mockLon = 6.6824816;
      const mockLat = 6.242381;

      test('make correct http request', () async {
        when(() => mockHttpResponse.statusCode).thenReturn(200);
        when(() => mockHttpResponse.body).thenReturn('{}');
        when(() => httpClient.get(any()))
            .thenAnswer((_) async => mockHttpResponse);
        try {
          await metaApiClient.getCurrentWeather(lat: mockLat, lon: mockLon);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(openWeatherApi, data_weather, queryParameters),
          ),
        ).called(1);
      });

      test('throws WeatherRequestFailure error when response code != 200',
          () async {
        when(() => mockHttpResponse.statusCode).thenReturn(400);
        when(() => httpClient.get(any()))
            .thenAnswer((_) async => mockHttpResponse);
        expect(
          () async =>
              metaApiClient.getCurrentWeather(lat: mockLat, lon: mockLon),
          throwsA(isA<WeatherRequestFailure>()),
        );
      });

      test('throws WeatherNotFoundFailure on empty response', () async {
        when(() => mockHttpResponse.statusCode).thenReturn(200);
        when(() => mockHttpResponse.body).thenReturn('{}');
        when(() => httpClient.get(any()))
            .thenAnswer((_) async => mockHttpResponse);
        expect(
          () async =>
              metaApiClient.getCurrentWeather(lat: mockLat, lon: mockLon),
          throwsA(isA<WeatherNotFoundFailure>()),
        );
      });

      test('returns weather on valid response', () {
        when(() => mockHttpResponse.statusCode).thenReturn(200);
        when(() => mockHttpResponse.body).thenReturn(
          '''
          {"consolidated_weather":[{
             "weather":"Showers",
            "min_temp":7.9399999999999995,
            "max_temp":13.239999999999998,
            "temp":12.825,
          }]}
        ''',
        );
      });
    });
  });
}
