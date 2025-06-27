import 'package:domain/domain.dart';
import '../entities/cv_entity.dart';
import '../mappers/cv_mapper.dart';
import '../providers/cv_request_provider.dart';

class CvRequestRepositoryImpl implements CvRequestRepository {
  final CvRequestProvider cvRequestProvider;

  CvRequestRepositoryImpl({
    required this.cvRequestProvider,
  });

  @override
  Future<List<CvModel>> getCvRequestList(
    GetCvRequestListPayload payload,
  ) async {
    final List<CvEntity> listCvEntities =
        await cvRequestProvider.getCvRequestList(payload);

    final List<CvModel> listCvRequestModels =
        listCvEntities.map(CvMapper.toDomainModel).toList();

    return listCvRequestModels;
  }

  @override
  Future<void> addCvForRequest(AddCvForRequestPayload payload) {
    return cvRequestProvider.addCvForRequest(
      payload,
    );
  }

  @override
  Future<void> deleteCvFromRequest(DeleteCvFromRequestPayload payload) {
    return cvRequestProvider.deleteCvFromRequest(
      payload,
    );
  }

  @override
  Future<void> addCvRequest(AddCvRequestPayload payload) {
    return cvRequestProvider.addCvRequest(
      payload,
    );
  }
}
