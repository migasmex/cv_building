import '../../models/models.dart';
import '../../payloads/payloads.dart';
import '../../repositories/repositories.dart';
import '../export_use_cases.dart';

class GetCvRequestListUseCase
    implements FutureUseCase<GetCvRequestListPayload, List<CvModel>> {
  final CvRequestRepository _cvRequestRepository;
  final CvRepository _cvRepository;

  GetCvRequestListUseCase({
    required CvRequestRepository cvRequestRepository,
    required CvRepository cvRepository,
  })  : _cvRequestRepository = cvRequestRepository,
        _cvRepository = cvRepository;

  @override
  Future<List<CvModel>> execute(
    GetCvRequestListPayload payload,
  ) async {
    final List<CvModel> cvRequestList =
        await _cvRequestRepository.getCvRequestList(
      payload,
    );

    switch (payload.cvListType) {
      case CvListType.cvRequestList:
        return cvRequestList;

      case CvListType.basicCvList:
        final List<CvModel> loadedCvs = await _cvRepository.getLoadedCvs();
        
        final Set<String> cvRequestIds = cvRequestList
            .map(
              (CvModel cv) => cv.id,
            )
            .toSet();

        final List<CvModel> basicCvs = loadedCvs
            .where(
              (CvModel cv) => !cvRequestIds.contains(cv.id),
            )
            .toList();

        return basicCvs;
    }
  }
}
