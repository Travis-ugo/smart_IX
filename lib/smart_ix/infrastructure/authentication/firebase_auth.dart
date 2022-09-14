import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:smart_ix/smart_ix/infrastructure/infrastructure.dart';

class AuthenticationRepository implements IAuthentication {
  final CacheClient _cache;
  final GoogleSignIn _googleSignIn;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthenticationRepository({
    CacheClient? cache,
    GoogleSignIn? googleSignIn,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  static const userCacheKey = '__user_cache__key';

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;

      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

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

  @override
  Future<void> loginWithGoogle() async {
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
      throw LoginWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LoginWithGoogleFailure();
    }
  }

  @override
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw LoginWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LoginWithEmailAndPasswordFailure();
    }
  }

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
