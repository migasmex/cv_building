import 'package:core/core.dart';
import 'package:domain/domain.dart';

class ErrorHandler {
  final AppEventNotifier _eventNotifier;

  ErrorHandler({
    required AppEventNotifier eventNotifier,
  }) : _eventNotifier = eventNotifier;

  Future<Never> handleError(DioException error) async {
    final Response<dynamic>? response = error.response;

    if (response == null) {
      throw const AppException(message: 'empty response');
    }

    if (error.type == DioExceptionType.connectionError) {
      _eventNotifier.notify(const InternetConnectionLostEvent());
      throw const AppException(message: 'no connection');
    }

    final int? statusCode = response.statusCode;
    switch (statusCode) {
      case 400:
        {
          throw AppException(
            message: error.response?.data['message'] ?? 'empty message',
          );
        }
      case 401:
        {
          _eventNotifier.notify(const UnauthorizedEvent());

          throw AppException(
            message: error.response?.data['message'] ?? 'no auth',
          );
        }
      case 500:
        {
          throw AppException(
            message: error.response?.data['message'] ?? 'server error',
          );
        }
      default:
        {
          throw AppException.unknown(
            AppConstants.unknownErrorKey,
          );
        }
    }
  }
}
