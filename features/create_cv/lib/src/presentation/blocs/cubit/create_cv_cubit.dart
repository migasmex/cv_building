import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';

part 'create_cv_state.dart';

class CreateCvCubit extends Cubit<CreateCvState> {
  final AddCvUseCase addCvUseCase;
  final GetCvUseCase getCvUseCase;
  final AddCvForRequestUseCase addCvForRequestUseCase;
  final CurrentUserIdUseCase currentUserIdUseCase;

  CreateCvCubit({
    required this.addCvUseCase,
    required this.getCvUseCase,
    required this.addCvForRequestUseCase,
    required this.currentUserIdUseCase,
  }) : super(
          CreateCvInitial(),
        );

  Future<String?> addCv(CreateCvModel cv) async {
    try {
      final AddCvPayload payload = AddCvPayload(createCvModel: cv);

      return addCvUseCase.execute(payload);
    } catch (e) {
      emit(
        CreateCvError(
          message: e.toString(),
        ),
      );
    }
    return null;
  }

  Future<void> addNewCvRequest(String cvIdToLoad) async {
    try {
      final CvModel cvModel = await getCvUseCase.execute(cvIdToLoad);

      final String userId = currentUserIdUseCase.execute(
        const NoParams(),
      );

      final AddCvForRequestPayload payload = AddCvForRequestPayload(
        cvModel: cvModel,
        userId: userId,
      );

      await addCvForRequestUseCase.execute(
        payload,
      );
    } on Exception catch (e) {
      emit(
        CreateCvError(
          message: e.toString(),
        ),
      );
    }
  }
}
