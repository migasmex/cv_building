import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../app_router/app_router.dart';

abstract class NavigationDI {
  static void initDependencies(GetIt locator) {
    locator.registerSingleton(
      AppRouter(
        isUserAuthorizedUseCase: appLocator<IsUserAuthorizedUseCase>(),
      ),
    );
  }
}
