import '../../payloads/payloads.dart';
import '../../repositories/repositories.dart';
import '../export_use_cases.dart';

class DeleteCvFromRequestUseCase
    implements FutureUseCase<DeleteCvFromRequestPayload, void> {
  final CvRequestRepository _cvRequestRepository;

  DeleteCvFromRequestUseCase({
    required CvRequestRepository cvRequestRepository,
  }) : _cvRequestRepository = cvRequestRepository;

  @override
  Future<void> execute(DeleteCvFromRequestPayload cvRequestPayload) {
    return _cvRequestRepository.deleteCvFromRequest(
      cvRequestPayload,
    );
  }
}
