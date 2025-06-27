import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/cv_entity.dart';
import 'api_constants.dart';
import 'cv_remote_datasource_provider.dart';

class CvFirestoreProviderImpl implements CvProvider {
  final FirebaseFirestore firestore;

  CvFirestoreProviderImpl({
    required this.firestore,
  });

  @override
  Future<String> addCv(Map<String, dynamic> data) async {
    final DocumentReference<Map<String, dynamic>> docRef =
        await firestore.collection(ApiConstants.cvCollection).add(data);
    return docRef.id;
  }

  @override
  Future<void> deleteCv(String id) async {
    await firestore.collection(ApiConstants.cvCollection).doc(id).delete();
  }

  @override
  Future<List<CvEntity>> getAllCvs() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection(ApiConstants.cvCollection).get();
    return querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      return CvEntity.fromMap(
        doc.data(),
        doc.id,
      );
    }).toList();
  }

  @override
  Future<CvEntity> getCv(String id) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection(ApiConstants.cvCollection).doc(id).get();
    return CvEntity.fromMap(
      snapshot.data()!,
      snapshot.id,
    );
  }
}
