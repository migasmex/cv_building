import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_remote_datasource_provider.dart';

class AuthFirebaseProviderImpl implements AuthRemoteDatasourceProvider {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on Exception catch (_) {
      throw LogoutException(
        AppConstants.logoutFailedKey,
      );
    }
  }

  @override
  Future<void> signIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw SignInException(
          AppConstants.signInFailedKey,
        );
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (_) {
      throw AuthenticationException(
        AppConstants.authenticationFailedKey,
      );
    }
  }

  @override
  Future<String?> getCurrentUserToken() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser!.getIdToken();
    }
    return null;
  }

  @override
  String currentUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}
