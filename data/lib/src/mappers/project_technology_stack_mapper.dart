import 'package:domain/domain.dart';

import '../entities/project_technology_stack_entity.dart';

class ProjectTechnologyStackMapper {
  static ProjectTechnologyStackEntity toEntity(ProjectTechnologyStackModel model) {
    return ProjectTechnologyStackEntity(
      category: model.category,
      name: model.name,
    );
  }

  static ProjectTechnologyStackModel toModel(ProjectTechnologyStackEntity entity) {
    return ProjectTechnologyStackModel(
      category: entity.category,
      name: entity.name,
    );
  }
}
