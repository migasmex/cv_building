import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase _signInUseCase;

  SignInBloc({
    required SignInUseCase signInUseCase,
  })  : _signInUseCase = signInUseCase,
        super(const SignInState()) {
    on<SignInRequestedEvent>(_onSignInRequested);
  }

  Future<void> _onSignInRequested(
    SignInRequestedEvent event,
    Emitter<SignInState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: SignInStatus.loading,
        ),
      );
      
      await _signInUseCase.execute();

      emit(
        state.copyWith(
          status: SignInStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SignInStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }
}
