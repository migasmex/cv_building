part of 'managing_project_cubit.dart';

final class ManagingProjectState {
  final ProjectModel? project;
  final String? errorText;

  ManagingProjectState({
    this.project,
    this.errorText,
  });

  ManagingProjectState copyWith({
    String? errorText,
    ProjectModel? project,
  }) {
    return ManagingProjectState(
      errorText: errorText ?? this.errorText,
      project: project ?? this.project,
    );
  }
}
