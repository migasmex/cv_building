import '../../domain.dart';

class GetCvUseCase {
  final CvRepository _cvRepository;

  GetCvUseCase({
    required CvRepository cvRepository,
  }) : _cvRepository = cvRepository;

  Future<CvModel> execute(String id) {
    return _cvRepository.getCv(id);
  }
}
