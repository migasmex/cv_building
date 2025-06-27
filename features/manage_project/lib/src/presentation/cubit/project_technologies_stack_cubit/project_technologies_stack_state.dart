part of 'project_technologies_stack_cubit.dart';

class ProjectTechnologiesStackState {
  final List<ProjectTechnologyStackModel>? technologyStack;

  ProjectTechnologiesStackState({
    this.technologyStack,
  });

  ProjectTechnologiesStackState copyWith({
    List<ProjectTechnologyStackModel>? technologyStack,
  }) {
    return ProjectTechnologiesStackState(
      technologyStack: technologyStack ?? technologyStack,
    );
  }
}
