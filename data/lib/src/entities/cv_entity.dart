import 'package:cloud_firestore/cloud_firestore.dart';

class CvEntity {
  final String? id;
  final String title;
  final double experience;
  final String grade;
  final String language;
  final String education;
  final List<String> domains;
  final String selfIntroTitle;
  final String selfIntro;
  final bool isBasic;
  final Timestamp createdAt;
  final Map<String, String> achievements;

  CvEntity({
    this.id,
    required this.title,
    required this.experience,
    required this.grade,
    required this.language,
    required this.education,
    required this.domains,
    required this.selfIntroTitle,
    required this.selfIntro,
    required this.isBasic,
    required this.createdAt,
    required this.achievements,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'experience': experience,
      'language': language,
      'grade': grade,
      'education': education,
      'domains': domains,
      'selfIntroTitle': selfIntroTitle,
      'selfIntro': selfIntro,
      'isBasic': isBasic,
      'createdAt': createdAt,
      'achievements': achievements,
    };
  }

  factory CvEntity.fromMap(Map<String, dynamic> map, String id) {
    return CvEntity(
      id: id,
      title: map['title'],
      experience: map['experience'],
      language: map['language'],
      grade: map['grade'],
      education: map['education'],
      domains: List<String>.from(map['domains']),
      selfIntroTitle: map['selfIntroTitle'],
      selfIntro: map['selfIntro'],
      isBasic: map['isBasic'],
      createdAt: map['createdAt'],
      achievements: Map<String, String>.from(map['achievements']),
    );
  }
}
