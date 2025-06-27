import 'package:core/core.dart';
import 'package:core/generated/l10n.dart';

import 'app_exception.dart';

class CvRequestException extends AppException {
  CvRequestException(int key)
      : super(
          message: AppLocalization.current.getExceptionMessage(key),
        );
}
