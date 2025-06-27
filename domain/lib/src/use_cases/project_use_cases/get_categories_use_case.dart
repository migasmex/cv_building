import '../../models/models.dart';
import '../../payloads/payloads.dart';
import '../../repositories/repositories.dart';
import '../use_case.dart';

class FetchCategoriesUseCase
    implements FutureUseCase<FetchCategoriesPayload, List<CategoryModel>> {
  final ProjectRepository _projectRepository;

  FetchCategoriesUseCase({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;

  @override
  Future<List<CategoryModel>> execute(
    FetchCategoriesPayload payload,
  ) {
    return _projectRepository.fetchCategories(
      payload,
    );
  }
}
