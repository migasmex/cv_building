class CvModel {
  final String id;
  final String title;
  final double experience;
  final String grade;
  final String language;
  final String education;
  final List<String> domains;
  final String selfIntroTitle;
  final String selfIntro;
  final bool isBasic;
  final DateTime createdAt;
  final Map<String, String> achievements;

  CvModel({
    required this.id,
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
}
