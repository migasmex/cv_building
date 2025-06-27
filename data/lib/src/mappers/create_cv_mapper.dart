import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';

import '../entities/cv_entity.dart';


class CreateCvMapper {
  static CvEntity toDataCreateModel(CreateCvModel cv) {
    return CvEntity(
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
}
