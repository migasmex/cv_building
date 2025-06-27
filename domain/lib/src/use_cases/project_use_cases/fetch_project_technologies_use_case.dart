import '../../models/project_technology_model.dart';
import '../../repositories/project_repository.dart';
import '../export_use_cases.dart';

class FetchProjectTechnologiesUseCase
    implements FutureUseCase<NoParams, List<ProjectTechnologyModel>> {
  final ProjectRepository _projectRepository;

  FetchProjectTechnologiesUseCase({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;

  @override
  Future<List<ProjectTechnologyModel>> execute([NoParams? noParams]) {
    return _projectRepository.fetchProjectTechnologies();
  }
}
