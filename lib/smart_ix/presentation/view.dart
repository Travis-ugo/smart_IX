import 'package:flutter/services.dart';

import 'core/models.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required RoutineRepository routineRepository,
    required MetaAPiClient metaAPiClient,
  })  : _authenticationRepository = authenticationRepository,
        _routineRepository = routineRepository,
        _metaAPiClient = metaAPiClient;

  final AuthenticationRepository _authenticationRepository;
  final RoutineRepository _routineRepository;
  final MetaAPiClient _metaAPiClient;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => RoutineCubit(_routineRepository),
          ),
          BlocProvider(
            create: (_) => RoutinesBloc(
              routineRepository: _routineRepository,
            )..add(LoadRoutine()),
          ),
          BlocProvider(
            create: (_) => WeatherBloc(
              metaAPiClient: _metaAPiClient,
            )..add(
                const LoadWeatherEvent(),
              ),
          ),
          BlocProvider(
            create: (_) => AppBloc(
              authenticationRepository: _authenticationRepository,
            ),
            child: const AppView(),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
