import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class SignInUseCase implements FutureUseCase<NoParams, void> {
  SignInUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  Future<void> execute([NoParams? noParams]) {
    return _authRepository.signIn();
  }
}
