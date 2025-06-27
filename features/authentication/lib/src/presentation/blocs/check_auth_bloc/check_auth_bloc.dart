import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'check_auth_event.dart';

part 'check_auth_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final IsUserAuthorizedUseCase _isUserAuthorizedUseCase;

  SplashBloc({
    required IsUserAuthorizedUseCase isUserAuthorizedUseCase,
  })  : _isUserAuthorizedUseCase = isUserAuthorizedUseCase,
        super(const SplashState()) {
    on<SplashRequest>(_onAuthCheckRequested);
    add(SplashRequest());
  }

  Future<void> _onAuthCheckRequested(
    SplashRequest event,
    Emitter<SplashState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SplashStatus.loading,
      ),
    );

    final bool isAuthorized = await _isUserAuthorizedUseCase.execute();

    final SplashStatus status = isAuthorized
        ? SplashStatus.authenticated
        : SplashStatus.unauthenticated;

    emit(
      state.copyWith(
        status: status,
      ),
    );
  }
}
