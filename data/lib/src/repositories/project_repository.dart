import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../../data.dart';
import '../mappers/category_mapper.dart';
import '../mappers/domain_mapper.dart';
import '../mappers/language_mapper.dart';
import '../mappers/project_technology_mapper.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDatasourceProvider firestoreProvider;

  ProjectRepositoryImpl({
    required this.firestoreProvider,
  });

  @override
  Future<void> addProject(
    AddProjectPayload payload,
  ) {
    return firestoreProvider.addProject(
      payload,
    );
  }

  @override
  Future<void> deleteProject(
    DeleteProjectPayload deleteProjectPayload,
  ) {
    return firestoreProvider.deleteProject(
      deleteProjectPayload,
    );
  }

  @override
  Future<ProjectModel> getProject(
    GetProjectPayload payload,
  ) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestoreProvider.getProject(
      payload,
    );

    if (snapshot.exists) {
      return ProjectMapper.toDomainModel(
        ProjectEntity.fromMap(
          snapshot.data()!,
        ),
      );
    } else {
      throw NoProjectsFoundException(
        AppConstants.noProjectsFoundKey,
      );
    }
  }

  @override
  Future<List<ProjectModel>> getAllProjectsByCvId(
    String cvId,
  ) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestoreProvider.getAllProjectsByCvId(
      cvId,
    );

    return querySnapshot.docs.map(
      (
        QueryDocumentSnapshot<Map<String, dynamic>> doc,
      ) {
        final Map<String, dynamic> data = doc.data();

        final ProjectEntity projectEntity = ProjectEntity.fromMap(
          data,
        );

        return ProjectMapper.toDomainModel(
          projectEntity,
        );
      },
    ).toList();
  }

  @override
  Future<void> updateProject(
    UpdateProjectPayload payload,
  ) {
    return firestoreProvider.updateProject(
      payload,
    );
  }

  @override
  Future<List<ProjectReviewModel>> getDomainProjects(
    GetDomainProjectsPayload payload,
  ) async {
    final List<ProjectReviewEntity> projectReviewEntities =
        await firestoreProvider.getDomainProjects(
      payload,
    );

    return projectReviewEntities
        .map(
          ProjectReviewMapper.toDomainModel,
        )
        .toList();
  }

  @override
  Future<List<DomainModel>> getDomains() async {
    final List<DomainEntity> domainEntities =
        await firestoreProvider.getDomains();

    return domainEntities
        .map(
          DomainMapper.toDomainModel,
        )
        .toList();
  }

  @override
  Future<List<LanguageModel>> fetchLanguages() async {
    final List<LanguageEntity> languageEntities =
        await firestoreProvider.fetchLanguages();

    return languageEntities
        .map(
          LanguageMapper.toDomainModel,
        )
        .toList();
  }

  @override
  Future<List<CategoryModel>> fetchCategories(
    FetchCategoriesPayload payload,
  ) async {
    final List<CategoryEntity> categoryEntities =
        await firestoreProvider.fetchCategories(
      payload,
    );

    return categoryEntities
        .map(
          CategoryMapper.toDomainModel,
        )
        .toList();
  }

  @override
  Future<List<ProjectTechnologyModel>> fetchProjectTechnologies() async {
    final List<ProjectTechnologyEntity> technologyEntities =
        await firestoreProvider.fetchProjectTechnologies();

    return technologyEntities
        .map(ProjectTechnologyMapper.toDomainModel)
        .toList();
  }

  Future<List<ProjectTechnologyStackModel>>
      fetchProjectTechnologiesStack() async {
    final List<ProjectTechnologyStackEntity> technologyStackEntities =
        await firestoreProvider.fetchProjectTechnologiesStack();

    return technologyStackEntities
        .map(ProjectTechnologyStackMapper.toModel)
        .toList();
  }
}
