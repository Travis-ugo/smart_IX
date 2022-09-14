import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_ix/smart_ix/application/application.dart';
import 'package:smart_ix/smart_ix/application/authentication/auth_bloc/app_bloc.dart';

class MockUser extends Mock implements User {}

void main() {
  group('AppEvent', () {
    group('App UserChanged', () {
      test('support value comparison', () {
        final user = MockUser();
        expect(
          AppUserChanged(user),
          AppUserChanged(user),
        );
      });

      group('App Logout request', () {
        test('support value comparison', () {
          expect(
            AppLogoutRequest(),
            AppLogoutRequest(),
          );
        });
      });
    });
  });
}
