import 'category_entity.dart';

class LanguageEntity {
  final String language;
  final List<CategoryEntity> categories;

  LanguageEntity({
    required this.language,
    required this.categories,
  });
}
