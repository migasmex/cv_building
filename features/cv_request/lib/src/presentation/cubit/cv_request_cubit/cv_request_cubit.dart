import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';

part 'cv_request_state.dart';

class CvRequestCubit extends Cubit<CvRequestState> {
  final GetCvRequestListUseCase getCvRequestListUseCase;
  final DeleteCvFromRequestUseCase deleteCvFromRequestUseCase;
  final AddCvForRequestUseCase addCvForRequestUseCase;
  final GetCvUseCase getCvUseCase;
  final CurrentUserIdUseCase currentUserIdUseCase;

  CvRequestCubit({
    required this.getCvRequestListUseCase,
    required this.deleteCvFromRequestUseCase,
    required this.addCvForRequestUseCase,
    required this.getCvUseCase,
    required this.currentUserIdUseCase,
  }) : super(
          const CvRequestState(),
        ) {
    getCvRequestList();
  }

  Future<void> getCvRequestList() async {
    try {
      emit(
        state.copyWith(
          status: CvRequestStateStatus.loading,
        ),
      );

      final String userId = currentUserIdUseCase.execute(
        const NoParams(),
      );

      final GetCvRequestListPayload payload = GetCvRequestListPayload(
        cvListType: CvListType.cvRequestList,
        userId: userId,
      );

      final List<CvModel> cvRequestList =
          await getCvRequestListUseCase.execute(payload);
      emit(
        state.copyWith(
          allCvsRequest: cvRequestList,
          status: CvRequestStateStatus.loaded,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: CvRequestStateStatus.failure,
          errorText: '$e',
        ),
      );
    }
  }

  Future<void> deleteNewCvRequest(CvModel cvModel) async {
    try {
      emit(
        state.copyWith(
          status: CvRequestStateStatus.loading,
        ),
      );

      final String userId = currentUserIdUseCase.execute(
        const NoParams(),
      );

      final DeleteCvFromRequestPayload payload = DeleteCvFromRequestPayload(
        cvModel: cvModel,
        userId: userId,
      );

      await deleteCvFromRequestUseCase.execute(
        payload,
      );
      final List<CvModel> updatedCvs =
          List<CvModel>.from(state.allCvsRequest ?? <CvModel>[])
            ..remove(cvModel);

      emit(
        state.copyWith(
          allCvsRequest: updatedCvs,
          status: CvRequestStateStatus.loaded,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: CvRequestStateStatus.failure,
          errorText: '$e',
        ),
      );
    }
  }
}
