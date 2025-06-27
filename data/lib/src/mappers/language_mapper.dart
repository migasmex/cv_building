import 'package:domain/domain.dart';

import '../entities/language_entity.dart';
import 'category_mapper.dart';

class LanguageMapper {
  static LanguageEntity toDataModel(LanguageModel model) {
    return LanguageEntity(
      language: model.language,
      categories: model.categories
          .map(
            CategoryMapper.toDataModel,
          )
          .toList(),
    );
  }

  static LanguageModel toDomainModel(LanguageEntity entity) {
    return LanguageModel(
      language: entity.language,
      categories: entity.categories
          .map(
            CategoryMapper.toDomainModel,
          )
          .toList(),
    );
  }
}
