import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_ix/smart_ix/application/application.dart';
import 'package:smart_ix/smart_ix/application/authentication/sign_in_cubit/signin_cubit.dart';

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
  group('SigninCubit', () {
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();

      when(
        () => authenticationRepository.signinWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async {});

      when(() => authenticationRepository.signinWithGoogle())
          .thenAnswer((_) async {});
    });

    test('Signin state set as initial state', () {
      expect(SigninCubit(authenticationRepository).state, const SigninState());
    });

    group('Email changed', () {
      blocTest<SigninCubit, SigninState>(
        'emits [invalid] when email are invalid',
        build: () => SigninCubit(authenticationRepository),
        act: (bloc) => bloc.emailChanged(invalidEmailString),
        expect: () => const <SigninState>[
          SigninState(email: invalidEmail, status: FormzStatus.invalid),
        ],
      );

      blocTest<SigninCubit, SigninState>(
        'emits [valid] when email/password are valid',
        build: () => SigninCubit(authenticationRepository),
        act: (bloc) => bloc.emailChanged(validEmailString),
        seed: () => const SigninState(password: validPassword),
        expect: () => const <SigninState>[
          SigninState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('Password changed', () {
      blocTest<SigninCubit, SigninState>(
        'emits [invalid] when password are invalid',
        build: () => SigninCubit(authenticationRepository),
        act: (bloc) => bloc.passwordChanged(invalidPasswordString),
        expect: () => const <SigninState>[
          SigninState(status: FormzStatus.invalid, password: invalidPassword),
        ],
      );
      blocTest<SigninCubit, SigninState>(
        'emits [valid] when password are valid',
        build: () => SigninCubit(authenticationRepository),
        seed: () => const SigninState(email: validEmail),
        act: (bloc) => bloc.passwordChanged(validPasswordString),
        expect: () => const <SigninState>[
          SigninState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('SigninWithCredentials', () {
      blocTest<SigninCubit, SigninState>(
        'does nothing when status is not validated',
        build: () => SigninCubit(authenticationRepository),
        act: (bloc) => bloc.signInWithCredentials(),
        expect: () => <SigninState>[],
      );

      blocTest<SigninCubit, SigninState>(
        'calls SigninWithEmailAndPassword with correct email/password',
        build: () => SigninCubit(authenticationRepository),
        seed: () => const SigninState(
          email: validEmail,
          password: validPassword,
          status: FormzStatus.valid,
        ),
        act: (bloc) => bloc.signInWithCredentials(),
        verify: (_) {
          verify(
            () => authenticationRepository.signinWithEmailAndPassword(
              email: validEmailString,
              password: validPasswordString,
            ),
          ).called(1);
        },
      );

      blocTest<SigninCubit, SigninState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when SigninWithEmailAndPassword succeeds',
        build: () => SigninCubit(authenticationRepository),
        seed: () => const SigninState(
          email: validEmail,
          password: validPassword,
          status: FormzStatus.valid,
        ),
        act: (bloc) => bloc.signInWithCredentials(),
        expect: () => <SigninState>[
          const SigninState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.submissionInProgress,
          ),
          const SigninState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.submissionSuccess,
          ),
        ],
      );

      blocTest<SigninCubit, SigninState>(
        'emits [submissionInProgress, submissionFailure] '
        'when SigninWithEmailAndPassword fails',
        build: () => SigninCubit(authenticationRepository),
        setUp: (() {
          when(
            () => authenticationRepository.signinWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenThrow(Exception('unfortunate'));
        }),
        seed: () => const SigninState(
          email: validEmail,
          password: validPassword,
          status: FormzStatus.valid,
        ),
        act: (bloc) => bloc.signInWithCredentials(),
        expect: () => <SigninState>[
          const SigninState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.submissionInProgress,
          ),
          const SigninState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.submissionFailure,
          ),
        ],
      );
    });

    group('SigninWithGoogle', () {
      blocTest<SigninCubit, SigninState>(
        'calls SigninWithGoogle',
        build: () => SigninCubit(authenticationRepository),
        act: (bloc) => bloc.signInWithGoogle(),
        verify: (_) {
          verify(() => authenticationRepository.signinWithGoogle()).called(1);
        },
      );

      blocTest<SigninCubit, SigninState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when SigninWithGoogle succeeds',
        build: () => SigninCubit(authenticationRepository),
        act: (bloc) => bloc.signInWithGoogle(),
        expect: () => const <SigninState>[
          SigninState(status: FormzStatus.submissionInProgress),
          SigninState(
            status: FormzStatus.submissionSuccess,
          ),
        ],
      );

      blocTest<SigninCubit, SigninState>(
        'emits [submissionInProgress, submissionFailure] '
        'when SigninWithGoogle fails',
        build: () => SigninCubit(authenticationRepository),
        setUp: (() {
          when(() => authenticationRepository.signinWithGoogle())
              .thenThrow(Exception('Signin failed'));
        }),
        act: (bloc) => bloc.signInWithGoogle(),
        expect: () => const <SigninState>[
          SigninState(status: FormzStatus.submissionInProgress),
          SigninState(
            status: FormzStatus.submissionFailure,
          ),
        ],
      );
    });
  });
}
