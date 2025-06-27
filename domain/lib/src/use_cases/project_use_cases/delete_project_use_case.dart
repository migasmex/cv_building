import '../../payloads/payloads.dart';
import '../../repositories/repositories.dart';
import '../use_case.dart';

class DeleteProjectUseCase implements FutureUseCase<DeleteProjectPayload, void>{
  final ProjectRepository _projectRepository;

  DeleteProjectUseCase({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;

  @override
  Future<void> execute(DeleteProjectPayload deleteProjectPayload) {
    return _projectRepository.deleteProject(deleteProjectPayload);
  }
}
