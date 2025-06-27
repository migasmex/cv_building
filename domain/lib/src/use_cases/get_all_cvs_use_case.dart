import '../../domain.dart';

class GetAllCvsUseCase implements FutureUseCase<NoParams, List<CvModel>>{
  final CvRepository _cvRepository;

  GetAllCvsUseCase({
    required CvRepository cvRepository,
  }) : _cvRepository = cvRepository;

  @override
  Future<List<CvModel>> execute([NoParams? noParams]) {
    return _cvRepository.getLoadedCvs();
  }
}