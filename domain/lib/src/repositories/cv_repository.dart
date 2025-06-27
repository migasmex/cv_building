import '../../domain.dart';

abstract class CvRepository {
  Future<String> addCv(AddCvPayload payload);

  Future<CvModel> getCv(String id);

  Future<void> deleteCv(String id);

  Future<List<CvModel>> getAllCvs();

  Future<List<CvModel>> getLoadedCvs();

}
