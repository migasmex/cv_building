import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';

part 'choose_cv_state.dart';

class ChoosingCvCubit extends Cubit<ChoosingCvState> {
  GetAllCvsUseCase getAllCvsUseCase;

  ChoosingCvCubit({
    required this.getAllCvsUseCase,
  }) : super(
          ChoosingCvState(),
        ) {
    fetchAllCvs();
  }

  Future<void> fetchAllCvs() async {
    try {
      emit(
        state.copyWith(
          status: ChoosingCvStateStatus.loading,
        ),
      );

      final List<CvModel> allCvs = await getAllCvsUseCase.execute();
      emit(
        state.copyWith(
          allCvs: allCvs,
          status: ChoosingCvStateStatus.loaded,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: ChoosingCvStateStatus.failure,
          errorText: '$e',
        ),
      );
    }
  }
}
