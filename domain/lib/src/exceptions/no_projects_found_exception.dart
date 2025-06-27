import 'package:core/core.dart';
import 'package:core/generated/l10n.dart';

import '../../domain.dart';

class NoProjectsFoundException extends AppException {
  NoProjectsFoundException(int key)
      : super(
          message: AppLocalization.current.getExceptionMessage(key),
        );
}
