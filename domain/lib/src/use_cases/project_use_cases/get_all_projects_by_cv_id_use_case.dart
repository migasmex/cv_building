import '../../models/models.dart';
import '../../repositories/repositories.dart';

class GetAllProjectsByCvIdUseCase {
  final ProjectRepository _projectRepository;

  GetAllProjectsByCvIdUseCase({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;

  Future<List<ProjectModel>> execute(String cvId) {
    return _projectRepository.getAllProjectsByCvId(cvId);
  }
}