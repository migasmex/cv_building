import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';

import '../entities/cv_entity.dart';

class CvMapper {
  static CvEntity toDataModel(CvModel cv) {
    return CvEntity(
      id: cv.id,
      title: cv.title,
      language: cv.language,
      grade: cv.grade,
      education: cv.education,
      domains: cv.domains,
      selfIntroTitle: cv.selfIntroTitle,
      selfIntro: cv.selfIntro,
      experience: cv.experience,
      isBasic: cv.isBasic,
      createdAt: Timestamp.fromDate(cv.createdAt),
      achievements: cv.achievements,
    );
  }

  static CvModel toDomainModel(CvEntity cv) {
    return CvModel(
      id: cv.id ?? '',
      title: cv.title,
      experience: cv.experience,
      grade: cv.grade,
      language: cv.language,
      education: cv.education,
      domains: cv.domains,
      selfIntroTitle: cv.selfIntroTitle,
      selfIntro: cv.selfIntro,
      isBasic: cv.isBasic,
      createdAt: cv.createdAt.toDate(),
      achievements: cv.achievements,
    );
  }
}
