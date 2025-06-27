import 'package:domain/domain.dart';

import '../entities/entities.dart';

abstract class CvRequestProvider {
  Future<List<CvEntity>> getCvRequestList(GetCvRequestListPayload payload);

  Future<void> addCvForRequest(AddCvForRequestPayload payload);

  Future<void> deleteCvFromRequest(DeleteCvFromRequestPayload payload);

  Future<void> addCvRequest(AddCvRequestPayload payload);
}
