import 'package:domain/domain.dart';

import '../entities/project_technology_entity.dart';

class ProjectTechnologyMapper {
  static ProjectTechnologyEntity toDataModel(ProjectTechnologyModel model) {
    return ProjectTechnologyEntity(
      category: model.category,
      name: model.name,
    );
  }

  static ProjectTechnologyModel toDomainModel(ProjectTechnologyEntity entity) {
    return ProjectTechnologyModel(
      category: entity.category,
      name: entity.name,
    );
  }
}
