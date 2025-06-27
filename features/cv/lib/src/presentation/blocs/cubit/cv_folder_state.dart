part of 'cv_folder_cubit.dart';

enum CvFolderStateStatus { loading, loaded, failure }

final class CvFolderState {
  final List<CvModel>? allCvs;
  final List<CvModel>? filteredCvs;
  final CvFolderStateStatus status;
  final String? errorText;

  CvFolderState({
    this.allCvs,
    this.filteredCvs,
    this.status = CvFolderStateStatus.loading,
    this.errorText,
  });

  CvFolderState copyWith({
    CvFolderStateStatus? status,
    String? errorText,
    List<CvModel>? allCvs,
    List<CvModel>? filteredCvs,
  }) {
    return CvFolderState(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      allCvs: allCvs ?? this.allCvs,
      filteredCvs: filteredCvs ?? this.filteredCvs,
    );
  }
}
