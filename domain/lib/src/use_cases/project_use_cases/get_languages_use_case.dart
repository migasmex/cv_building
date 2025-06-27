import '../../models/models.dart';
import '../../repositories/project_repository.dart';
import '../export_use_cases.dart';

class FetchLanguagesUseCase implements FutureUseCase<NoParams, List<LanguageModel>> {
  final ProjectRepository _projectRepository;

  FetchLanguagesUseCase({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;

  @override
  Future<List<LanguageModel>> execute([
    NoParams? noParams,
  ]) {
    return _projectRepository.fetchLanguages();
  }
}
