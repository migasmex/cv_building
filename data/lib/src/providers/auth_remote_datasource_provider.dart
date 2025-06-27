abstract class AuthRemoteDatasourceProvider {
  Future<void> signIn();

  Future<void> logout();

  Future<String?> getCurrentUserToken();

  String currentUserId();
}
