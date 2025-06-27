import '../../models/project_technology_stack_model.dart';

import '../../repositories/project_repository.dart';
import '../export_use_cases.dart';

class FetchProjectTechnologiesStackUseCase
    implements FutureUseCase<NoParams, List<ProjectTechnologyStackModel>> {
  final ProjectRepository _projectRepository;

  FetchProjectTechnologiesStackUseCase({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;

  @override
  Future<List<ProjectTechnologyStackModel>> execute([NoParams? noParams]) {
    return _projectRepository.fetchProjectTechnologiesStack();
  }
}
