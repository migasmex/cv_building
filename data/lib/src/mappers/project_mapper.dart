import 'package:domain/domain.dart';

import '../../data.dart';

class ProjectMapper {
  static ProjectEntity toDataModel(ProjectModel project) {
    return ProjectEntity(
      id: project.id,
      cvId: project.cvId,
      title: project.title,
      description: project.description,
      role: project.role,
      period: project.period,
      environment: project.environment,
        achievements: project.achievementList,
    );
  }

  static ProjectModel toDomainModel(ProjectEntity project) {
    return ProjectModel(
      id: project.id,
      cvId: project.cvId,
      title: project.title,
      description: project.description,
      role: project.role,
      period: project.period,
      environment: project.environment,
      achievementList: project.achievements,
    );
  }
}
