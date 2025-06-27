import '../../domain.dart';

class AddCvUseCase implements FutureUseCase<AddCvPayload, String>{
  final CvRepository _cvRepository;

  AddCvUseCase({
    required CvRepository cvRepository,
  }) : _cvRepository = cvRepository;

  @override
  Future<String> execute(AddCvPayload payload) {
    return _cvRepository.addCv(payload);
  }
}
