import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_ix/smart_ix/application/application.dart';
import 'package:smart_ix/smart_ix/application/authentication/auth_bloc/app_bloc.dart';

class MockAuthentication extends Mock implements AuthenticationRepository {}

class MockUser extends Mock implements User {}

void main() {
  group(
    'AppBloc',
    () {
      late AuthenticationRepository authenticationRepository;
      late User user;

      setUp(() {
        authenticationRepository = MockAuthentication();
        user = MockUser();
        when(() => authenticationRepository.user).thenAnswer(
          (_) => const Stream.empty(),
        );

        when(() => authenticationRepository.currentUser).thenReturn(User.empty);
      });

      test('initial state is unauthenticated', () {
        expect(
          AppBloc(authenticationRepository: authenticationRepository).state,
          const AppState.unauthenticated(),
        );
      });

      group(
        'User changed',
        () {
          blocTest<AppBloc, AppState>(
            'emits authenticated when user is not empty',
            build: () => AppBloc(
              authenticationRepository: authenticationRepository,
            ),
            setUp: (() {
              when(() => user.isNotEmpty).thenReturn(true);
              when(() => authenticationRepository.user).thenAnswer(
                (_) => Stream.value(user),
              );
            }),
            seed: AppState.unauthenticated,
            expect: () => [AppState.authenticated(user)],
          );

          blocTest<AppBloc, AppState>(
            'emits unauthenticated when user is empty',
            build: () => AppBloc(
              authenticationRepository: authenticationRepository,
            ),
            setUp: (() {
              when(() => authenticationRepository.user).thenAnswer(
                (_) => Stream.value(User.empty),
              );
            }),
            expect: () => [const AppState.unauthenticated()],
          );
        },
      );

      group(
        'Logout changed',
        () {
          blocTest<AppBloc, AppState>(
            'logout request',
            build: () => AppBloc(
              authenticationRepository: authenticationRepository,
            ),
            setUp: (() {
              when(() => authenticationRepository.logOut())
                  .thenAnswer((_) async {});
            }),
            act: (bloc) => bloc.add(AppLogoutRequest()),
            verify: (_) {
              verify(() => authenticationRepository.logOut()).called(1);
            },
          );
        },
      );
    },
  );
}
