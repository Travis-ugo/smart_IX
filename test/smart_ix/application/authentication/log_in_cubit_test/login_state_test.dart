import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:smart_ix/smart_ix/application/application.dart';
import 'package:smart_ix/smart_ix/application/authentication/log_in_cubit/login_cubit.dart';

void main() {
  group('LoginState', () {
    const email = Email.dirty('email');
    const password = Password.dirty('password');
    test('support value comparison', () {
      expect(const LoginState(), const LoginState());
    });

    test('values return same object when state does not change', () {
      expect(
          const LoginState().copyWith(
            status: FormzStatus.pure,
            email: const Email.pure(),
          ),
          const LoginState());
    });

    test('returns object with updated email', () {
      expect(
        const LoginState().copyWith(
          email: email,
        ),
        const LoginState(email: email),
      );
    });
    test('returns object with updated password', () {
      expect(
        const LoginState().copyWith(
          password: password,
        ),
        const LoginState(password: password),
      );
    });
  });
}
