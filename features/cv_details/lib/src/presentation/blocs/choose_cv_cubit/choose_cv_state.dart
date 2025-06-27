part of 'choose_cv_cubit.dart';

enum ChoosingCvStateStatus { loading, loaded, failure }

final class ChoosingCvState {
  final List<CvModel>? allCvs;
  final ChoosingCvStateStatus status;
  final String? errorText;

  ChoosingCvState({
    this.allCvs,
    this.status = ChoosingCvStateStatus.loading,
    this.errorText,
  });

  ChoosingCvState copyWith({
    ChoosingCvStateStatus? status,
    String? errorText,
    List<CvModel>? allCvs,
  }) {
    return ChoosingCvState(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      allCvs: allCvs ?? this.allCvs,
    );
  }
}
