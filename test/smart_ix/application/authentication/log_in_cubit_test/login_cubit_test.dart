import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_ix/smart_ix/application/application.dart';
import 'package:smart_ix/smart_ix/application/authentication/log_in_cubit/login_cubit.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  const invalidEmailString = 'invalid email';
  const invalidEmail = Email.dirty(invalidEmailString);

  const validEmailString = 'test@gmail.com';
  const validEmail = Email.dirty(validEmailString);

  const invalidPasswordString = 'invalid password';
  const invalidPassword = Password.dirty(invalidPasswordString);

  const validPasswordString = 'TestPassword123';
  const validPassword = Password.dirty(validPasswordString);
  group('LoginCubit', () {
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();

      when(
        () => authenticationRepository.loginWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async {});

      when(() => authenticationRepository.loginWithGoogle())
          .thenAnswer((_) async {});
    });

    test('Login state set as initial state', () {
      expect(LoginCubit(authenticationRepository).state, const LoginState());
    });

    group('Email changed', () {
      blocTest<LoginCubit, LoginState>(
        'emits [invalid] when email are invalid',
        build: () => LoginCubit(authenticationRepository),
        act: (bloc) => bloc.emailChanged(invalidEmailString),
        expect: () => const <LoginState>[
          LoginState(email: invalidEmail, status: FormzStatus.invalid),
        ],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [valid] when email/password are valid',
        build: () => LoginCubit(authenticationRepository),
        act: (bloc) => bloc.emailChanged(validEmailString),
        seed: () => const LoginState(password: validPassword),
        expect: () => const <LoginState>[
          LoginState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('Password changed', () {
      blocTest<LoginCubit, LoginState>(
        'emits [invalid] when password are invalid',
        build: () => LoginCubit(authenticationRepository),
        act: (bloc) => bloc.passwordChanged(invalidPasswordString),
        expect: () => const <LoginState>[
          LoginState(status: FormzStatus.invalid, password: invalidPassword),
        ],
      );
      blocTest<LoginCubit, LoginState>(
        'emits [valid] when password are valid',
        build: () => LoginCubit(authenticationRepository),
        seed: () => const LoginState(email: validEmail),
        act: (bloc) => bloc.passwordChanged(validPasswordString),
        expect: () => const <LoginState>[
          LoginState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('logInWithCredentials', () {
      blocTest<LoginCubit, LoginState>(
        'does nothing when status is not validated',
        build: () => LoginCubit(authenticationRepository),
        act: (bloc) => bloc.logInWithCredentials(),
        expect: () => <LoginState>[],
      );

      blocTest<LoginCubit, LoginState>(
        'calls logInWithEmailAndPassword with correct email/password',
        build: () => LoginCubit(authenticationRepository),
        seed: () => const LoginState(
          email: validEmail,
          password: validPassword,
          status: FormzStatus.valid,
        ),
        act: (bloc) => bloc.logInWithCredentials(),
        verify: (_) {
          verify(
            () => authenticationRepository.loginWithEmailAndPassword(
              email: validEmailString,
              password: validPasswordString,
            ),
          ).called(1);
        },
      );

      blocTest<LoginCubit, LoginState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when logInWithEmailAndPassword succeeds',
        build: () => LoginCubit(authenticationRepository),
        seed: () => const LoginState(
          email: validEmail,
          password: validPassword,
          status: FormzStatus.valid,
        ),
        act: (bloc) => bloc.logInWithCredentials(),
        expect: () => <LoginState>[
          const LoginState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.submissionInProgress,
          ),
          const LoginState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.submissionSuccess,
          ),
        ],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [submissionInProgress, submissionFailure] '
        'when logInWithEmailAndPassword fails',
        build: () => LoginCubit(authenticationRepository),
        setUp: (() {
          when(
            () => authenticationRepository.loginWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenThrow(Exception('unfortunate'));
        }),
        seed: () => const LoginState(
          email: validEmail,
          password: validPassword,
          status: FormzStatus.valid,
        ),
        act: (bloc) => bloc.logInWithCredentials(),
        expect: () => <LoginState>[
          const LoginState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.submissionInProgress,
          ),
          const LoginState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.submissionFailure,
          ),
        ],
      );
    });

    group('logInWithGoogle', () {
      blocTest<LoginCubit, LoginState>(
        'calls loginWithGoogle',
        build: () => LoginCubit(authenticationRepository),
        act: (bloc) => bloc.logInWithGoogle(),
        verify: (_) {
          verify(() => authenticationRepository.loginWithGoogle()).called(1);
        },
      );

      blocTest<LoginCubit, LoginState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when logInWithGoogle succeeds',
        build: () => LoginCubit(authenticationRepository),
        act: (bloc) => bloc.logInWithGoogle(),
        expect: () => const <LoginState>[
          LoginState(status: FormzStatus.submissionInProgress),
          LoginState(
            status: FormzStatus.submissionSuccess,
          ),
        ],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [submissionInProgress, submissionFailure] '
        'when logInWithGoogle fails',
        build: () => LoginCubit(authenticationRepository),
        setUp: (() {
          when(() => authenticationRepository.loginWithGoogle())
              .thenThrow(Exception('login failed'));
        }),
        act: (bloc) => bloc.logInWithGoogle(),
        expect: () => const <LoginState>[
          LoginState(status: FormzStatus.submissionInProgress),
          LoginState(
            status: FormzStatus.submissionFailure,
          ),
        ],
      );
    });
  });
}
