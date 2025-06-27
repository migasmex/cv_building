import 'package:core/core.dart';
import 'package:core/generated/l10n.dart';

class AppException implements Exception {
  final String message;

  const AppException({required this.message});

  factory AppException.unknown(int key) {
    return AppException(
      message: AppLocalization.current.getExceptionMessage(key),
    );
  }

  @override
  String toString() => message;
}
