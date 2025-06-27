import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';

part 'cv_state.dart';

class CvCubit extends Cubit<CvState> {
  final GetAllCvsUseCase getAllCvsUseCase;
  final AddCvRequestUseCase addCvRequestUseCase;
  final CurrentUserIdUseCase currentUserIdUseCase;

  CvCubit({
    required this.getAllCvsUseCase,
    required this.addCvRequestUseCase,
    required this.currentUserIdUseCase,
  }) : super(
          CvState(),
        ) {
    fetchAllCvs();
  }

  Future<void> fetchAllCvs() async {
    try {
      emit(
        state.copyWith(
          status: CvStateStatus.loading,
        ),
      );

      final List<CvModel> cvs = await getAllCvsUseCase.execute();

      emit(
        state.copyWith(
          allCvs: cvs,
          status: CvStateStatus.loaded,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: CvStateStatus.failure,
          errorText: '$e',
        ),
      );
    }
  }

  List<String> generateCvFolders() {
    final Set<String> uniqueYears = state.allCvs!
        .map(
          (CvModel cv) => cv.createdAt.year.toString(),
        )
        .toSet();

    final List<String> folderNames = uniqueYears.toList()..sort();

    folderNames.add('BasicCVs');

    return folderNames;
  }

  Future<void> addRequestForUser() async {
    try {
      final String userId = currentUserIdUseCase.execute(
        const NoParams(),
      );

      final CvRequestModel cvRequestModel = CvRequestModel(
        cvIdList: <String>[],
        userId: userId,
      );

      final AddCvRequestPayload payload = AddCvRequestPayload(
        cvRequestModel: cvRequestModel,
      );

      await addCvRequestUseCase.execute(payload);
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: CvStateStatus.failure,
          errorText: '$e',
        ),
      );
    }
  }
}
