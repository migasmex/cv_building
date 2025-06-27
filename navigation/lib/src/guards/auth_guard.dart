import 'package:authentication/authentication.gm.dart';
import 'package:domain/domain.dart';
import '../../navigation.dart';

class AuthGuard extends AutoRouteGuard {
  final IsUserAuthorizedUseCase isUserAuthorizedUseCase;

  AuthGuard(
    this.isUserAuthorizedUseCase,
  );

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final bool isAuthorized = await isUserAuthorizedUseCase.execute();
    if (isAuthorized) {
      resolver.next();
    } else {
      await router.replace(
        const SignInRoute(),
      );
    }
  }
}
