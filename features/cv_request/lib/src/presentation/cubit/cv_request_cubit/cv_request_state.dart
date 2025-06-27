part of 'cv_request_cubit.dart';

enum CvRequestStateStatus { loading, loaded, failure }

final class CvRequestState {
  final List<CvModel>? allCvsRequest;
  final CvRequestStateStatus status;
  final String? errorText;

  const CvRequestState({
    this.allCvsRequest,
    this.status = CvRequestStateStatus.loading,
    this.errorText,
  });

  CvRequestState copyWith({
    CvRequestStateStatus? status,
    String? errorText,
    List<CvModel>? allCvsRequest,
    List<CvModel>? filteredCvs,
  }) {
    return CvRequestState(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      allCvsRequest: allCvsRequest ?? this.allCvsRequest,
    );
  }
}
