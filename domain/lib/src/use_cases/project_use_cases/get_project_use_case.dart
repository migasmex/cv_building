import '../../models/models.dart';
import '../../payloads/payloads.dart';
import '../../repositories/repositories.dart';
import '../use_case.dart';

class GetProjectUseCase implements FutureUseCase<GetProjectPayload, ProjectModel> {
  final ProjectRepository _projectRepository;

  GetProjectUseCase({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;

  @override
  Future<ProjectModel> execute(GetProjectPayload payload) {
    return _projectRepository.getProject(payload);
  }
}
