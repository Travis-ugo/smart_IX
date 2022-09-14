import 'package:flutter_test/flutter_test.dart';

import 'package:smart_ix/smart_ix/application/application.dart';
import 'package:smart_ix/smart_ix/application/authentication/sign_up_cubit/signup_cubit.dart';

void main() {
  const email = Email.dirty('email');
  const password = Password.dirty('password');
  const confirmPassword = ConfirmedPassword.dirty(
    password: 'password',
    value: 'password',
  );

  group('SignUp State', () {
    test('support value comparison', () {
      expect(const SignupState(), const SignupState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        const SignupState().copyWith(status: FormzStatus.pure),
        const SignupState(),
      );
    });

    test(
        'return object with updated email,password, confirm password input, when passed',
        () {
      expect(
        const SignupState().copyWith(
            email: email,
            password: password,
            confirmedPassword: confirmPassword),
        const SignupState(
          email: email,
          password: password,
          confirmedPassword: confirmPassword,
        ),
      );
    });
  });
}
