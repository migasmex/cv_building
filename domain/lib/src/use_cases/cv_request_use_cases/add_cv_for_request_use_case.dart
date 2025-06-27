import '../../payloads/payloads.dart';
import '../../repositories/repositories.dart';
import '../export_use_cases.dart';

class AddCvForRequestUseCase implements FutureUseCase<AddCvForRequestPayload, void> {
  final CvRequestRepository _cvRequestRepository;

  AddCvForRequestUseCase({
    required CvRequestRepository cvRequestRepository,
  }) : _cvRequestRepository = cvRequestRepository;

  @override
  Future<void> execute(AddCvForRequestPayload payload) {
    return _cvRequestRepository.addCvForRequest(
      payload,
    );
  }
}
