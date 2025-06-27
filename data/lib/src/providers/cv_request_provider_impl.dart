import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import '../entities/cv_request_entity.dart';
import '../entities/entities.dart';
import '../mappers/cv_mapper.dart';
import '../mappers/cv_request_mapper.dart';
import 'api_constants.dart';
import 'providers.dart';

class CvRequestProviderImpl implements CvRequestProvider {
  final CvProvider cvProvider;

  CvRequestProviderImpl({
    required this.cvProvider,
  });

  final CollectionReference<Map<String, dynamic>> _cvRequest =
      FirebaseFirestore.instance.collection(
    ApiConstants.cvRequestCollection,
  );

  @override
  Future<void> addCvRequest(AddCvRequestPayload payload) async {
    final CvRequestEntity dataModel = CvRequestMapper.toDataModel(
      payload.cvRequestModel,
    );

    final Map<String, dynamic> data = dataModel.toMap();

    final Query<Map<String, dynamic>> userQuery = _cvRequest.where(
      'userId',
      isEqualTo: payload.cvRequestModel.userId,
    );

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await userQuery.get();

    if (querySnapshot.docs.isEmpty) {
      final DocumentReference<Object?> docRef = _cvRequest.doc();
      await docRef.set(data);
    }
  }

  Future<CvRequestEntity> _getCvRequest(String userId) async {
    final Query<Map<String, dynamic>> userQuery = _cvRequest.where(
      'userId',
      isEqualTo: userId,
    );

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await userQuery.get();

    if (querySnapshot.docs.isEmpty) {
      throw CvRequestException(
        AppConstants.cvDoesntExistsKey,
      );
    }

    final Map<String, dynamic> data = querySnapshot.docs.first.data();

    return CvRequestEntity.fromMap(data);
  }

  @override
  Future<List<CvEntity>> getCvRequestList(
    GetCvRequestListPayload payload,
  ) async {
    final CvRequestEntity cvRequestEntity = await _getCvRequest(
      payload.userId,
    );

    final List<CvEntity> cvEntities = <CvEntity>[];

    for (final String id in cvRequestEntity.cvIdList) {
      final CvEntity cvEntity = await cvProvider.getCv(id);
      cvEntities.add(
        cvEntity,
      );
    }
    return cvEntities;
  }

  @override
  Future<void> addCvForRequest(AddCvForRequestPayload payload) async {
    final CvRequestEntity cvRequestEntity = await _getCvRequest(payload.userId);

    final CvEntity cvEntity = CvMapper.toDataModel(
      payload.cvModel,
    );

    if (cvEntity.id != null && cvEntity.id!.isNotEmpty) {
      cvRequestEntity.cvIdList.add(cvEntity.id!);
    }

    final Query<Map<String, dynamic>> userQuery = _cvRequest.where(
      'userId',
      isEqualTo: payload.userId,
    );

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await userQuery.get();

    await querySnapshot.docs.first.reference.update(
      cvRequestEntity.toMap(),
    );
  }

  @override
  Future<void> deleteCvFromRequest(DeleteCvFromRequestPayload payload) async {
    final CvRequestEntity cvRequestEntity = await _getCvRequest(payload.userId);

    final CvEntity cvEntity = CvMapper.toDataModel(payload.cvModel);

    cvRequestEntity.cvIdList.remove(cvEntity.id);

    final Query<Map<String, dynamic>> userQuery = _cvRequest.where(
      'userId',
      isEqualTo: payload.userId,
    );

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await userQuery.get();

    await querySnapshot.docs.first.reference.update(
      cvRequestEntity.toMap(),
    );
  }
}
