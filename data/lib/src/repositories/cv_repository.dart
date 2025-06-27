import 'package:domain/domain.dart';

import '../entities/cv_entity.dart';
import '../mappers/mappers.dart';
import '../providers/cv_remote_datasource_provider.dart';

class CvRepositoryImpl implements CvRepository {
  List<CvModel> _cachedCvs = <CvModel>[];
  final CvProvider firestoreProvider;

  CvRepositoryImpl({
    required this.firestoreProvider,
  });

  @override
  Future<String> addCv(AddCvPayload payload) {
    _cachedCvs = <CvModel>[];
    return firestoreProvider.addCv(
      CreateCvMapper.toDataCreateModel(payload.createCvModel).toMap(),
    );
  }

  @override
  Future<void> deleteCv(String id) {
    return firestoreProvider.deleteCv(id);
  }

  @override
  Future<CvModel> getCv(String id) async {
    final CvEntity cvEntity = await firestoreProvider.getCv(id);
    return CvMapper.toDomainModel(cvEntity);
  }

  @override
  Future<List<CvModel>> getAllCvs() async {
    final List<CvEntity> cvEntities = await firestoreProvider.getAllCvs();
    return cvEntities.map(CvMapper.toDomainModel).toList();
  }

  @override
  Future<List<CvModel>> getLoadedCvs() async {
    if (_cachedCvs.isEmpty) {
      _cachedCvs = await getAllCvs();
    }
    return _cachedCvs;
  }
}
