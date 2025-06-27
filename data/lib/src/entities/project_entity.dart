class ProjectEntity {
  final String? id;
  final String cvId;
  final String title;
  final String description;
  final String role;
  final String period;
  final List<String> environment;
  final List<String> achievements;

  ProjectEntity({
    required this.id,
    required this.cvId,
    required this.title,
    required this.description,
    required this.role,
    required this.period,
    required this.environment,
    required this.achievements,
  });

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'id' : id,
      'cvId': cvId,
      'title': title,
      'description': description,
      'role': role,
      'period': period,
      'environment': environment,
      'achievements' : achievements,
    };
  }

  factory ProjectEntity.fromMap(Map<String, dynamic> map) {
    return ProjectEntity(
      id: map['id'],
      cvId: map['cvId'],
      title: map['title'],
      description: map['description'],
      role: map['role'],
      period: map['period'],
      environment: List<String>.from(map['environment']),
      achievements: List<String>.from(map['achievements']),
    );
  }
}
