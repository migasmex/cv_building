import '../../models/models.dart';
import '../../repositories/project_repository.dart';
import '../export_use_cases.dart';

class GetDomainsUseCase implements FutureUseCase<NoParams, List<DomainModel>> {
  final ProjectRepository _projectRepository;

  GetDomainsUseCase({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;

  @override
  Future<List<DomainModel>> execute([
    NoParams? noParams,
  ]) {
    return _projectRepository.getDomains();
  }
}
