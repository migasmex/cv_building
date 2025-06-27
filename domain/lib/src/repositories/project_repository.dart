import '../../domain.dart';

abstract class ProjectRepository {
  Future<void> addProject(
    AddProjectPayload payload,
  );

  Future<ProjectModel> getProject(
    GetProjectPayload payload,
  );

  Future<void> deleteProject(
    DeleteProjectPayload deleteProjectPayload,
  );

  Future<List<ProjectModel>> getAllProjectsByCvId(
    String cvId,
  );

  Future<void> updateProject(
    UpdateProjectPayload payload,
  );

  Future<List<ProjectReviewModel>> getDomainProjects(
    GetDomainProjectsPayload payload,
  );

  Future<List<DomainModel>> getDomains();

  Future<List<ProjectTechnologyModel>> fetchProjectTechnologies();

  Future<List<LanguageModel>> fetchLanguages();

  Future<List<CategoryModel>> fetchCategories(
    FetchCategoriesPayload payload,
  );

  Future<List<ProjectTechnologyStackModel>> fetchProjectTechnologiesStack();
}
