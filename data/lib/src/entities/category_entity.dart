class CategoryEntity {
  final String category;
  final List<String> responsibilities;

  CategoryEntity({
    required this.category,
    required this.responsibilities,
  });

  factory CategoryEntity.fromMap(Map<String, dynamic> map) {
    return CategoryEntity(
      category: map['category'],
      responsibilities: List<String>.from(map['responsibilities'] as List<dynamic>),
    );
  }
}
