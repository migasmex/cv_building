import '../../repositories/repositories.dart';
import '../export_use_cases.dart';

class CurrentUserIdUseCase implements UseCase<NoParams, String> {
  final AuthRepository _authRepository;

  CurrentUserIdUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  String execute(NoParams? noParams) {
    return _authRepository.currentUserId();
  }
}
