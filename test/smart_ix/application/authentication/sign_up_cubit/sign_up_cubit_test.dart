import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_ix/smart_ix/application/application.dart';
import 'package:smart_ix/smart_ix/application/authentication/sign_up_cubit/signup_cubit.dart';

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

  const invalidConfirmedPasswordString = 'invalid';
  const invalidConfirmPassword = ConfirmedPassword.dirty(
    password: validPasswordString,
    value: invalidConfirmedPasswordString,
  );

  const validConfirmedPasswordString = 'TestPassword123';
  const validConfirmPassword = ConfirmedPassword.dirty(
    password: validPasswordString,
    value: validConfirmedPasswordString,
  );

  group('SignUp cubit', () {
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();

      when(
        () => authenticationRepository.signUp(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async {});
    });

    test('initial State is signup', () {
      expect(SignupCubit(authenticationRepository).state, const SignupState());
    });

    group('Email changed', () {
      blocTest<SignupCubit, SignupState>(
        'emit invalid, when input parameters are invalid',
        build: () => SignupCubit(authenticationRepository),
        act: (cubit) => cubit.emailChanged(invalidEmailString),
        expect: () => const <SignupState>[
          SignupState(email: invalidEmail, status: FormzStatus.invalid),
        ],
      );

      blocTest<SignupCubit, SignupState>(
        'emit valid when input parameters are valid',
        build: () => SignupCubit(authenticationRepository),
        seed: () => const SignupState(
          password: validPassword,
          confirmedPassword: validConfirmPassword,
        ),
        act: (cubit) => cubit.emailChanged(validEmailString),
        expect: () => const <SignupState>[
          SignupState(
            email: validEmail,
            password: validPassword,
            confirmedPassword: validConfirmPassword,
            status: FormzStatus.valid,
          )
        ],
      );
    });

    group('Password Changed', () {
      blocTest<SignupCubit, SignupState>(
        'password invalid, when input parameters are invalid',
        build: () => SignupCubit(authenticationRepository),
        act: (cubit) => cubit.passwordChanged(invalidPasswordString),
        expect: () => const <SignupState>[
          SignupState(password: invalidPassword, status: FormzStatus.invalid)
        ],
      );
      blocTest<SignupCubit, SignupState>(
        'emit valid when input parameters are valid',
        build: () => SignupCubit(authenticationRepository),
        seed: () => const SignupState(
          email: validEmail,
          confirmedPassword: validConfirmPassword,
        ),
        act: (cubit) => cubit.passwordChanged(validPasswordString),
        expect: () => const <SignupState>[
          SignupState(
            email: validEmail,
            password: validPassword,
            confirmedPassword: validConfirmPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('Confirmed password', () {
      blocTest<SignupCubit, SignupState>(
        'password invalid, when input parameters are invalid',
        build: () => SignupCubit(authenticationRepository),
        act: (cubit) =>
            cubit.confirmPasswordChanged(invalidConfirmedPasswordString),
        expect: () => const <SignupState>[
          SignupState(
            confirmedPassword: invalidConfirmPassword,
            status: FormzStatus.invalid,
          ),
        ],
      );
      blocTest<SignupCubit, SignupState>(
        'emit valid when input parameters are valid',
        build: () => SignupCubit(authenticationRepository),
        seed: () =>
            const SignupState(email: validEmail, password: validPassword),
        act: (cubit) =>
            cubit.confirmPasswordChanged(validConfirmedPasswordString),
        expect: () => const <SignupState>[
          SignupState(
            email: validEmail,
            password: validPassword,
            confirmedPassword: validConfirmPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('Signup submitted Button', () {
      blocTest<SignupCubit, SignupState>(
        'emits nothing when status is not validated',
        build: () => SignupCubit(authenticationRepository),
        act: (cubit) => cubit.signupFormSubmitted(),
        expect: () => [],
      );

      blocTest<SignupCubit, SignupState>(
        'calls signUp with correct email/password/confirmedPassword',
        build: () => SignupCubit(authenticationRepository),
        seed: () => const SignupState(
          email: validEmail,
          password: validPassword,
          confirmedPassword: validConfirmPassword,
          status: FormzStatus.valid,
        ),
        act: (cubit) => cubit.signupFormSubmitted(),
        verify: (_) {
          verify(
            () => authenticationRepository.signUp(
                email: validEmailString,
                password: validConfirmedPasswordString),
          ).called(1);
        },
      );

      blocTest<SignupCubit, SignupState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when signUp succeeds',
        build: () => SignupCubit(authenticationRepository),
        seed: () => const SignupState(
          email: validEmail,
          password: validPassword,
          confirmedPassword: validConfirmPassword,
          status: FormzStatus.valid,
        ),
        act: (cubit) => cubit.signupFormSubmitted(),
        expect: () => <SignupState>[
          const SignupState(
            email: validEmail,
            password: validPassword,
            confirmedPassword: validConfirmPassword,
            status: FormzStatus.submissionInProgress,
          ),
          const SignupState(
            email: validEmail,
            password: validPassword,
            confirmedPassword: validConfirmPassword,
            status: FormzStatus.submissionSuccess,
          ),
        ],
      );

      blocTest<SignupCubit, SignupState>(
        'emits [submissionInProgress, submissionFailure] '
        'when signUp fails',
        build: () => SignupCubit(authenticationRepository),
        setUp: () {
          when(
            () => authenticationRepository.signUp(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenThrow(Exception('failed'));
        },
        seed: () => const SignupState(
          email: validEmail,
          password: validPassword,
          confirmedPassword: validConfirmPassword,
          status: FormzStatus.valid,
        ),
        act: (cubit) => cubit.signupFormSubmitted(),
        expect: () => const <SignupState>[
          SignupState(
            email: validEmail,
            password: validPassword,
            confirmedPassword: validConfirmPassword,
            status: FormzStatus.submissionInProgress,
          ),
          SignupState(
            email: validEmail,
            password: validPassword,
            confirmedPassword: validConfirmPassword,
            status: FormzStatus.submissionFailure,
          ),
        ],
      );
    });
  });
}
