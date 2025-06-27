import 'package:domain/domain.dart';

import '../entities/category_entity.dart';

class CategoryMapper {
  static CategoryEntity toDataModel(CategoryModel model) {
    return CategoryEntity(
      category: model.category,
      responsibilities: model.responsibilities,
    );
  }

  static CategoryModel toDomainModel(CategoryEntity entity) {
    return CategoryModel(
      category: entity.category,
      responsibilities: entity.responsibilities,
    );
  }
}
