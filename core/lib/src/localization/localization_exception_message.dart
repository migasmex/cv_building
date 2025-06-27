import '../../generated/l10n.dart';

extension LocalizationExceptionMessage on AppLocalization {
  String getExceptionMessage(int key) {
    switch (key) {
      case 1001:
        return authenticationFailed;
      case 1002:
        return unknownError;
      case 1003:
        return signInFailed;
      case 1004:
        return logoutFailed;
      case 1005:
        return cvDoesntExists;
      case 1006:
        return noProjectsFound;

      default:
        return unknownError;
    }
  }
}
