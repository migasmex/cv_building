import 'package:domain/domain.dart';

import '../providers/providers.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDatasourceProvider authFirebaseProvider,
  }) : _authFirebaseProvider = authFirebaseProvider;

  final AuthRemoteDatasourceProvider _authFirebaseProvider;

  @override
  Future<void> logout() {
    return _authFirebaseProvider.logout();
  }

  @override
  Future<void> signIn() {
    return _authFirebaseProvider.signIn();
  }

  @override
  Future<String?> getCurrentUserToken() async {
    return _authFirebaseProvider.getCurrentUserToken();
  }

  @override
  String currentUserId() {
    return _authFirebaseProvider.currentUserId();
  }
}
