import 'package:domain/domain.dart';

import '../entities/entities.dart';

class ProjectReviewMapper {
  static ProjectReviewEntity toDataModel(ProjectReviewModel model) {
    return ProjectReviewEntity(
      name: model.name,
      description: model.description,
    );
  }

  static ProjectReviewModel toDomainModel(ProjectReviewEntity entity) {
    return ProjectReviewModel(
      name: entity.name,
      description: entity.description,
    );
  }
}
