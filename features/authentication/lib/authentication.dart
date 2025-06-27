import 'package:auto_route/annotations.dart';

import 'authentication.gm.dart';

export 'package:authentication/authentication.dart';
export 'src/presentation/pages/sign_in_page.dart';

@AutoRouterConfig.module()
class AuthenticationModule extends $AuthenticationModule {}