import '../../payloads/add_project_payload.dart';
import '../../repositories/project_repository.dart';
import '../use_case.dart';

class AddProjectUseCase implements FutureUseCase<AddProjectPayload, void>{
  final ProjectRepository _projectRepository;

  AddProjectUseCase({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;

  @override
  Future<void> execute(AddProjectPayload payload)  {
    return _projectRepository.addProject(payload);
  }
}
