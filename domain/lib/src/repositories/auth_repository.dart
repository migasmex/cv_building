abstract class AuthRepository {
  Future<void> signIn();

  Future<void> logout();

  Future<String?> getCurrentUserToken();

  String currentUserId();
}
