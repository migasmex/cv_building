import '../../domain.dart';

class DeleteCvUseCase {
  final CvRepository _cvRepository;

  DeleteCvUseCase({
    required CvRepository cvRepository,
  }) : _cvRepository = cvRepository;

  Future<void> execute(String id) {
    return _cvRepository.deleteCv(id);
  }
}
