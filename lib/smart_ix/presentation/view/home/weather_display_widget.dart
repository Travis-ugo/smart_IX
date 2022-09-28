import 'package:smart_ix/smart_ix/presentation/view/home/home_model.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        if (state is WeatherApiLoadingState) {
          return const WeatherBox(
            iconData: Icons.cloudy_snowing,
            title: 'loading\n',
            subTitle: 'loading',
            temperature: '0°',
          );
        }
        if (state is WeatherApiLoadedState) {
          final temp = state.temperature.temp.toString();
          final hunch = temp.split('.');
          return WeatherBox(
            title: '${state.city}\n',
            subTitle: state.weatherInfo.description,
            iconData: Icons.cloudy_snowing,
            temperature: '${hunch[0]}°',
          );
        }

        return const Text('Nothing');
      }),
    );
  }
}
