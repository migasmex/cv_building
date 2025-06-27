import '../../payloads/payloads.dart';
import '../../repositories/repositories.dart';
import '../export_use_cases.dart';

class AddCvRequestUseCase implements FutureUseCase<AddCvRequestPayload, void> {
  final CvRequestRepository _cvRequestRepository;

  AddCvRequestUseCase({
    required CvRequestRepository cvRequestRepository,
  }) : _cvRequestRepository = cvRequestRepository;

  @override
  Future<void> execute(AddCvRequestPayload payload) {
    return _cvRequestRepository.addCvRequest(
      payload,
    );
  }
}
