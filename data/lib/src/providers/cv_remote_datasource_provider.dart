import '../entities/cv_entity.dart';

abstract class CvProvider {
  Future<String> addCv(Map<String, dynamic> data);

  Future<void> deleteCv(String id);

  Future<CvEntity> getCv(String id);

  Future<List<CvEntity>> getAllCvs();
}
