/// Firebase provides proper documentation for error handling,
/// and various authentication error. for more on error handling.
/// check out the link below.
/// https://pub.dev/documentation/firebase_auth_platform_interface/latest/firebase_auth_platform_interface/FirebaseAuthException-class.html

class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred',
  ]);

  final String message;

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}

class SigninWithEmailAndPasswordFailure implements Exception {
  final String message;

  const SigninWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred',
  ]);

  factory SigninWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SigninWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SigninWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const SigninWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const SigninWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const SigninWithEmailAndPasswordFailure();
    }
  }
}

class SigninWithGoogleFailure implements Exception {
  final String message;

  const SigninWithGoogleFailure([
    this.message = 'An unknown exception occurred',
  ]);

  factory SigninWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const SigninWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const SigninWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const SigninWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const SigninWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const SigninWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const SigninWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const SigninWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const SigninWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const SigninWithGoogleFailure();
    }
  }
}

class LogOutFailure implements Exception {}
