import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';

import '../entities/entities.dart';

abstract class ProjectRemoteDatasourceProvider {
  Future<void> addProject(
    AddProjectPayload payload,
  );

  Future<DocumentSnapshot<Map<String, dynamic>>> getProject(
    GetProjectPayload payload,
  );

  Future<void> deleteProject(
    DeleteProjectPayload deleteProjectPayload,
  );

  Future<QuerySnapshot<Map<String, dynamic>>> getAllProjectsByCvId(
    String cvId,
  );

  Future<void> updateProject(
    UpdateProjectPayload payload,
  );

  Future<List<DomainEntity>> getDomains();

  Future<List<ProjectReviewEntity>> getDomainProjects(
    GetDomainProjectsPayload payload,
  );

  Future<List<ProjectTechnologyEntity>> fetchProjectTechnologies();

  Future<List<LanguageEntity>> fetchLanguages();

  Future<List<CategoryEntity>> fetchCategories(
    FetchCategoriesPayload payload,
  );

  Future<List<ProjectTechnologyStackEntity>> fetchProjectTechnologiesStack();
}
