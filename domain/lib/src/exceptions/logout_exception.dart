import 'package:core/core.dart';
import 'package:core/generated/l10n.dart';

import '../../domain.dart';

class LogoutException extends AppException {
  LogoutException(int key)
      : super(
          message: AppLocalization.current.getExceptionMessage(key),
        );
}
