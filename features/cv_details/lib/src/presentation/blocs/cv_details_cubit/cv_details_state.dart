part of 'cv_details_cubit.dart';

sealed class CvDetailsState {}

final class CvDetailsInitial extends CvDetailsState {}

final class CvDetailsLoading extends CvDetailsState {}

final class CvDetailsLoaded extends CvDetailsState {
  final CvModel cv;
  final List<ProjectModel> projects;

  CvDetailsLoaded({
    required this.cv,
    required this.projects,
  });
}

final class CvDetailsLoadingFailure extends CvDetailsState {
  final String message;

  CvDetailsLoadingFailure({
    required this.message,
  });
}

final class CvExportError extends CvDetailsState {
  final String error;

  CvExportError({
    required this.error,
  });
}
