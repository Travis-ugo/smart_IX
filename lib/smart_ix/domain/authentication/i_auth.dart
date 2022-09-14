abstract class IAuthentication {
  Future<void> signUp({required String email, required String password});
  Future<void> loginWithEmailAndPassword(
      {required String email, required String password});
  Future<void> loginWithGoogle();
  Future<void> logOut();
}
