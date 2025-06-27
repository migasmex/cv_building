import '../models/models.dart';
import '../payloads/payloads.dart';

abstract class CvRequestRepository {
  Future<List<CvModel>> getCvRequestList(GetCvRequestListPayload payload);

  Future<void> addCvForRequest(AddCvForRequestPayload payload);

  Future<void> deleteCvFromRequest(DeleteCvFromRequestPayload payload);

  Future<void> addCvRequest(AddCvRequestPayload payload);
}
