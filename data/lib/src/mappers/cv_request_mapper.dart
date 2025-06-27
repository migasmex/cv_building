import 'package:domain/domain.dart';
import '../entities/cv_request_entity.dart';

class CvRequestMapper {
  static CvRequestEntity toDataModel(CvRequestModel cvRequest) {
    return CvRequestEntity(
      cvIdList: cvRequest.cvIdList,
      userId: cvRequest.userId,
    );
  }

  static CvRequestModel toDomainModel(CvRequestEntity cvRequest) {
    return CvRequestModel(
      cvIdList: cvRequest.cvIdList,
      userId: cvRequest.userId,
    );
  }
}
