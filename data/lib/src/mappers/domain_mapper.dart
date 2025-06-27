import 'package:domain/domain.dart';

import '../entities/domain_entity.dart';
import 'project_review_mapper.dart';

class DomainMapper {
  static DomainEntity toDataModel(DomainModel model) {
    return DomainEntity(
      name: model.name,
      projectReviews: model.projectReviews
          .map(
            ProjectReviewMapper.toDataModel,
          )
          .toList(),
    );
  }

  static DomainModel toDomainModel(DomainEntity entity) {
    return DomainModel(
      name: entity.name,
      projectReviews: entity.projectReviews
          .map(
            ProjectReviewMapper.toDomainModel,
          )
          .toList(),
    );
  }
}
