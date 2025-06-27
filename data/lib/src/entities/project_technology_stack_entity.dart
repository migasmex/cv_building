class ProjectTechnologyStackEntity {
  final String category;
  final String name;

  const ProjectTechnologyStackEntity({
    required this.category,
    required this.name,
  });

  factory ProjectTechnologyStackEntity.fromMap({
    required String category,
    required String name,
  }) {
    return ProjectTechnologyStackEntity(
      category: category,
      name: name,
    );
  }
}
