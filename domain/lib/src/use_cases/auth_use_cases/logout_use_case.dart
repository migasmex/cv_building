import '../../repositories/repositories.dart';
import '../export_use_cases.dart';

class LogoutUseCase implements FutureUseCase<NoParams, void> {
  LogoutUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  Future<void> execute([NoParams? noParams]) async {
    return _authRepository.logout();
  }
}
