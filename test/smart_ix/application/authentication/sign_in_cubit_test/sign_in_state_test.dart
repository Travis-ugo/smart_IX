import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:smart_ix/smart_ix/application/application.dart';
import 'package:smart_ix/smart_ix/application/authentication/sign_in_cubit/signin_cubit.dart';

void main() {
  group('SigninState', () {
    const email = Email.dirty('email');
    const password = Password.dirty('password');
    test('support value comparison', () {
      expect(const SigninState(), const SigninState());
    });

    test('values return same object when state does not change', () {
      expect(
          const SigninState().copyWith(
            status: FormzStatus.pure,
            email: const Email.pure(),
          ),
          const SigninState());
    });

    test('returns object with updated email', () {
      expect(
        const SigninState().copyWith(
          email: email,
        ),
        const SigninState(email: email),
      );
    });
    test('returns object with updated password', () {
      expect(
        const SigninState().copyWith(
          password: password,
        ),
        const SigninState(password: password),
      );
    });
  });
}
