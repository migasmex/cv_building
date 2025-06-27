part of 'project_technologies_cubit.dart';

class ProjectTechnologiesState {
  final List<ProjectTechnologyModel>? technologies;

  ProjectTechnologiesState({
    this.technologies,
  });

  ProjectTechnologiesState copyWith({
    List<ProjectTechnologyModel>? technologyStack,
  }) {
    return ProjectTechnologiesState(
      technologies: technologyStack ?? technologies,
    );
  }
}
