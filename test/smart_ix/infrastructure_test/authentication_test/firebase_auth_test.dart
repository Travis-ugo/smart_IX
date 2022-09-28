import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:smart_ix/smart_ix/application/application.dart';
import 'package:smart_ix/smart_ix/infrastructure/infrastructure.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

const _mockFirebaseUserUid = 'mock_uid';
const _mockFirebaseEmail = 'mock_email';

class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class MockFirebaseCore extends Mock
    with MockPlatformInterfaceMixin
    implements FirebasePlatform {}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockUserCredential extends Mock implements firebase_auth.UserCredential {}

class FakeAuthCredential extends Fake implements firebase_auth.AuthCredential {}

class FakeAuthProvider extends Fake implements AuthProvider {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const email = 'test@gmail.com';
  const password = 't0ps3cret42';

  const user = User(
    id: _mockFirebaseUserUid,
    email: _mockFirebaseEmail,
  );

  group('AuthenticationRepository', () {
    late firebase_auth.FirebaseAuth firebaseAuth;
    late GoogleSignIn googleSignIn;
    late AuthenticationRepository authenticationRepository;

    setUpAll(() {
      registerFallbackValue(FakeAuthCredential());
      registerFallbackValue(FakeAuthProvider());
    });

    setUp(() {
      const options = FirebaseOptions(
        apiKey: 'apiKey',
        appId: 'appId',
        projectId: 'projectId',
        messagingSenderId: 'messagingSenderId',
      );

      final platformApp = FirebaseAppPlatform(defaultFirebaseAppName, options);
      final firebaseCore = MockFirebaseCore();

      when(() => firebaseCore.apps).thenReturn([platformApp]);
      when(firebaseCore.app).thenReturn(platformApp);

      when(
        () => firebaseCore.initializeApp(
          name: defaultFirebaseAppName,
          options: options,
        ),
      ).thenAnswer((_) async => platformApp);

      Firebase.delegatePackingProperty = firebaseCore;

      firebaseAuth = MockFirebaseAuth();
      googleSignIn = MockGoogleSignIn();
      authenticationRepository = AuthenticationRepository(
        firebaseAuth: firebaseAuth,
        googleSignIn: googleSignIn,
      );
    });

    test('creates FirebaseAuth instance internally when not injected', () {
      expect(AuthenticationRepository.new, isNot(throwsException));
    });

    group('SignUp', () {
      setUp(() {
        when(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) => Future.value(MockUserCredential()));
      });

      test('calls createUserWithEmailAndPassword', () async {
        await authenticationRepository.signUp(
          email: email,
          password: password,
        );

        verify(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
      });

      test('succeeds when createUserWithEmailAndPassword succeeds', () async {
        expect(
          authenticationRepository.signUp(
            email: email,
            password: password,
          ),
          completes,
        );
      });

      test(
        'throws SignUpWithEmailAndPasswordFailure '
        'when createUserWithEmailAndPassword throws',
        () {
          when(() => firebaseAuth.createUserWithEmailAndPassword(
                email: any(named: 'email'),
                password: any(named: 'password'),
              )).thenThrow(Exception());

          expect(
            authenticationRepository.signUp(
              email: email,
              password: password,
            ),
            throwsA(isA<SignUpWithEmailAndPasswordFailure>()),
          );
        },
      );
    });

    group('SigninWithGoogle', () {
      const accessToken = 'access-token';
      const idToken = 'id-token';

      setUp(() {
        final googleSignInAccount = MockGoogleSignInAccount();
        final googleSignInAuthentication = MockGoogleSignInAuthentication();

        when(() => googleSignInAuthentication.accessToken)
            .thenReturn(accessToken);

        when(() => googleSignInAuthentication.idToken).thenReturn(idToken);

        when(() => googleSignInAccount.authentication)
            .thenAnswer((_) async => googleSignInAuthentication);

        when(() => googleSignIn.signIn())
            .thenAnswer((_) async => googleSignInAccount);

        when(() => firebaseAuth.signInWithCredential(any()))
            .thenAnswer((_) => Future.value(MockUserCredential()));

        when(() => firebaseAuth.signInWithPopup(any()))
            .thenAnswer((_) => Future.value(MockUserCredential()));
      });

      test('calls signIn authentication, and signInWithCredential', () async {
        await authenticationRepository.signinWithGoogle();
        verify(() => googleSignIn.signIn()).called(1);
        verify(() => firebaseAuth.signInWithCredential(any())).called(1);
      });

      test('succeeds when signIn withGoogle succeeds', () {
        expect(authenticationRepository.signinWithGoogle(), completes);
      });

      test('throws auth failure when error occurs', () {
        when(() => firebaseAuth.signInWithCredential(any()))
            .thenThrow(Exception());

        expect(
          authenticationRepository.signinWithGoogle(),
          throwsA(isA<SigninWithGoogleFailure>()),
        );
      });
    });

    group('Signin with email and password', () {
      setUp(() {
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
              email: any(named: 'email'), password: any(named: 'password')),
        ).thenAnswer((_) => Future.value(MockUserCredential()));
      });

      test('calls signInWithEmailAndPassword', () async {
        await authenticationRepository.signinWithEmailAndPassword(
            email: email, password: password);

        verify(() => firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password)).called(1);
      });

      test('succeeds when signInWithEmailAndPassword succeeds', () {
        expect(
          authenticationRepository.signinWithEmailAndPassword(
              email: email, password: password),
          completes,
        );
      });

      test(
          'throws SigninWithEmailAndPasswordFailure '
          'when signInWithEmailAndPassword throws', () {
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
              email: any(named: 'email'), password: any(named: 'password')),
        ).thenThrow(Exception());

        expect(
          authenticationRepository.signinWithEmailAndPassword(
              email: email, password: password),
          throwsA(
            isA<SigninWithEmailAndPasswordFailure>(),
          ),
        );
      });
    });
    group('logOut', () {
      test('calls signOut', () async {
        when(() => firebaseAuth.signOut()).thenAnswer((_) async {});
        when(() => googleSignIn.signOut()).thenAnswer((_) async => null);
        await authenticationRepository.logOut();
        verify(() => firebaseAuth.signOut()).called(1);
        verify(() => googleSignIn.signOut()).called(1);
      });

      test('throws LogOutFailure when signOut throws', () {
        when(() => firebaseAuth.signOut()).thenThrow(Exception());
        expect(
          authenticationRepository.logOut(),
          throwsA(isA<LogOutFailure>()),
        );
      });
    });
  });
}
