import '../../repositories/repositories.dart';
import '../export_use_cases.dart';

class IsUserAuthorizedUseCase implements FutureUseCase<NoParams, bool> {
  final AuthRepository _authRepository;

  IsUserAuthorizedUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<bool> execute([NoParams? noParams]) async {

    final String? userToken = await _authRepository.getCurrentUserToken();
    return userToken?.isNotEmpty ?? false;
  }
}
