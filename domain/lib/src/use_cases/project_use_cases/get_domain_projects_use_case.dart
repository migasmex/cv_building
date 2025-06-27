import '../../models/models.dart';
import '../../payloads/payloads.dart';
import '../../repositories/repositories.dart';
import '../use_case.dart';

class GetDomainProjectsUseCase
    implements FutureUseCase<GetDomainProjectsPayload, List<ProjectReviewModel>> {
  final ProjectRepository _projectRepository;

  GetDomainProjectsUseCase({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;

  @override
  Future<List<ProjectReviewModel>> execute(
    GetDomainProjectsPayload payload,
  ) {
    return _projectRepository.getDomainProjects(
      payload,
    );
  }
}
