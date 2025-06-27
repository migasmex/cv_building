part of 'cv_cubit.dart';

enum CvStateStatus { loading, loaded, failure }

final class CvState {
  final List<CvModel>? allCvs;
  final CvStateStatus status;
  final String? errorText;

  CvState({
    this.allCvs,
    this.status = CvStateStatus.loading,
    this.errorText,
  });

  CvState copyWith({
    CvStateStatus? status,
    String? errorText,
    List<CvModel>? allCvs,
  }) {
    return CvState(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      allCvs: allCvs ?? this.allCvs,
    );
  }
}
