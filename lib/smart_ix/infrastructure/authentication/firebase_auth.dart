import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:smart_ix/smart_ix/infrastructure/infrastructure.dart';

class AuthenticationRepository implements IAuthentication {
  final GoogleSignIn _googleSignIn;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthenticationRepository({
    GoogleSignIn? googleSignIn,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  /// gets current firebase user id.
  String get firebaseUserId {
    return _firebaseAuth.currentUser!.uid;
  }

  /// exposes a stream to get authentication status from firebase auth
  /// and emits a new value when the user is either authenticated or unauthenticated.
  var currentUser = User.empty;
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      currentUser = user;

      return user;
    });
  }

  /// firebase provides and easy signin and login function to authenticate users
  /// with email and password.
  /// the signup function is an implementation of the abstract method in the file:
  /// domain/database/i_routine.dart
  /// the signup function creates a new user account, and throws an error if the email,
  /// is already used
  @override
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Firebase provides and easy signup and sign in method with user social account
  /// the function below uses firebase easy social auth, google account to register
  /// or signin the user credentials.

  @override
  Future<void> signinWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw SigninWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const SigninWithGoogleFailure();
    }
  }

  /// firebase authentication with existing user email and password
  /// the function throws an error if the email and address does'nt match,
  /// or does not exist

  @override
  Future<void> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SigninWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SigninWithEmailAndPasswordFailure();
    }
  }

  /// the logout function to resets the authentication state, and sets the current user to null.
  @override
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, name: displayName, email: email, photo: photoURL);
  }
}
