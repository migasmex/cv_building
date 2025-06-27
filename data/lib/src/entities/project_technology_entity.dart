class ProjectTechnologyEntity {
  final String category;
  final String name;

  const ProjectTechnologyEntity({
    required this.category,
    required this.name,
  });

  factory ProjectTechnologyEntity.fromMap(
    String category,
    String name,
  ) {
    return ProjectTechnologyEntity(
      category: category,
      name: name,
    );
  }
}
