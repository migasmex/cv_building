class ProjectReviewEntity {
  final String name;
  final String description;

  ProjectReviewEntity({
    required this.name,
    required this.description,
  });

  factory ProjectReviewEntity.fromMap(Map<String, dynamic> map) {
    return ProjectReviewEntity(
      name: map['name'],
      description: map['description'],
    );
  }
}
