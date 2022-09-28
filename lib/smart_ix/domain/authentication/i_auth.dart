/// Authentication interface, to be implemented
/// in the authentication repository, the abstract methods are blueprints,
/// for the structure of the authentication repository.
abstract class IAuthentication {
  Future<void> signUp({required String email, required String password});
  Future<void> signinWithEmailAndPassword(
      {required String email, required String password});
  Future<void> signinWithGoogle();
  Future<void> logOut();
}
