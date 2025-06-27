import '../../payloads/payloads.dart';
import '../../repositories/repositories.dart';
import '../use_case.dart';

class UpdateProjectUseCase
    implements FutureUseCase<UpdateProjectPayload, void> {
  final ProjectRepository _projectRepository;

  UpdateProjectUseCase({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;

  @override
  Future<void> execute(UpdateProjectPayload payload) {
    return _projectRepository.updateProject(payload);
  }
}
