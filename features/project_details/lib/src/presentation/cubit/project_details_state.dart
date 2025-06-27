part of 'project_details_cubit.dart';

final class ProjectDetailsState {
  final ProjectModel? project;
  final ProjectDetailsStateStatus status;
  final String? errorText;

  ProjectDetailsState({
    this.project,
    this.status = ProjectDetailsStateStatus.loading,
    this.errorText,
  });

  ProjectDetailsState copyWith({
    ProjectDetailsStateStatus? status,
    String? errorText,
    ProjectModel? project,
  }) {
    return ProjectDetailsState(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      project: project ?? this.project,
    );
  }
}
