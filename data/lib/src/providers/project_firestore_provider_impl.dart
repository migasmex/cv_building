import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/services.dart';

import '../../data.dart';
import 'api_constants.dart';

class ProjectFirestoreProviderImpl implements ProjectRemoteDatasourceProvider {
  final FirebaseFirestore firestore;

  ProjectFirestoreProviderImpl({
    required this.firestore,
  });

  @override
  Future<void> addProject(
    AddProjectPayload payload,
  ) async {
    final Map<String, dynamic> data = ProjectMapper.toDataModel(
      payload.projectModel,
    ).toMap();

    final DocumentReference<Object?> docRef = firestore
        .collection(
          ApiConstants.projectsCollection,
        )
        .doc();

    data['id'] = docRef.id;
    await docRef.set(data);
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getProject(
    GetProjectPayload payload,
  ) {
    return firestore
        .collection(
          ApiConstants.projectsCollection,
        )
        .doc(
          payload.projectId,
        )
        .get();
  }

  @override
  Future<void> deleteProject(
    DeleteProjectPayload deleteProjectPayload,
  ) {
    return firestore
        .collection(
          ApiConstants.projectsCollection,
        )
        .doc(
          deleteProjectPayload.projectId,
        )
        .delete();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getAllProjectsByCvId(
    String cvId,
  ) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection(
          ApiConstants.projectsCollection,
        )
        .where(
          'cvId',
          isEqualTo: cvId,
        )
        .get();
    return querySnapshot;
  }

  @override
  Future<void> updateProject(
    UpdateProjectPayload payload,
  ) {
    final Map<String, dynamic> data = ProjectMapper.toDataModel(
      payload.projectModel,
    ).toMap();

    return firestore
        .collection(
          ApiConstants.projectsCollection,
        )
        .doc(
          data['id'],
        )
        .update(
          data,
        );
  }

  @override
  Future<List<DomainEntity>> getDomains() async {
    final String jsonString = await rootBundle.loadString(
      AppConstants.projectsJsonPath,
    );

    final Map<String, dynamic> jsonData = jsonDecode(
      jsonString,
    );

    return jsonData.entries.map(
      (
        MapEntry<String, dynamic> entry,
      ) {
        final String domainName = entry.key;

        final List<ProjectReviewEntity> projectReviews =
            (entry.value as List<dynamic>)
                .map(
                  (dynamic item) => ProjectReviewEntity.fromMap(
                    item as Map<String, dynamic>,
                  ),
                )
                .toList();

        return DomainEntity(
          name: domainName,
          projectReviews: projectReviews,
        );
      },
    ).toList();
  }

  @override
  Future<List<ProjectReviewEntity>> getDomainProjects(
    GetDomainProjectsPayload payload,
  ) async {
    final String jsonString = await rootBundle.loadString(
      AppConstants.projectsJsonPath,
    );

    final Map<String, dynamic> jsonData = jsonDecode(
      jsonString,
    );

    final List<dynamic> projectsJson =
        jsonData[payload.domain] as List<dynamic>;

    return projectsJson
        .map(
          (dynamic item) =>
              ProjectReviewEntity.fromMap(item as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<List<LanguageEntity>> fetchLanguages() async {
    final String jsonString = await rootBundle.loadString(
      AppConstants.responsibilitiesListJson,
    );

    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    return jsonData.entries.map(
      (MapEntry<String, dynamic> entry) {
        final String language = entry.key;
        final Map<String, dynamic> categoriesJson =
            entry.value as Map<String, dynamic>;

        final List<CategoryEntity> categories = categoriesJson.entries.map(
          (MapEntry<String, dynamic> categoryEntry) {
            final String category = categoryEntry.key;
            final List<String> responsibilities =
                List<String>.from(categoryEntry.value);

            return CategoryEntity(
              category: category,
              responsibilities: responsibilities,
            );
          },
        ).toList();

        return LanguageEntity(
          language: language,
          categories: categories,
        );
      },
    ).toList();
  }

  @override
  Future<List<CategoryEntity>> fetchCategories(
    FetchCategoriesPayload payload,
  ) async {
    final String jsonString = await rootBundle.loadString(
      AppConstants.responsibilitiesListJson,
    );

    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    final Map<String, dynamic> categoriesJson = jsonData[payload.language];

    final List<CategoryEntity> categories = categoriesJson.entries.map(
      (MapEntry<String, dynamic> entry) {
        final String category = entry.key;
        final List<String> responsibilities = List<String>.from(entry.value);

        return CategoryEntity(
          category: category,
          responsibilities: responsibilities,
        );
      },
    ).toList();

    return categories;
  }

  @override
  Future<List<ProjectTechnologyEntity>> fetchProjectTechnologies() async {
    final String jsonString = await rootBundle.loadString(
      AppConstants.technologiesListJson,
    );
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    final List<ProjectTechnologyEntity> technologies =
        <ProjectTechnologyEntity>[];

    for (final MapEntry<String, dynamic> categoryEntry in jsonData.entries) {
      final String category = categoryEntry.key;
      final List<dynamic> technologyList = categoryEntry.value as List<dynamic>;

      for (final dynamic item in technologyList) {
        technologies.add(
          ProjectTechnologyEntity(
            category: category,
            name: item as String,
          ),
        );
      }
    }

    return technologies;
  }

  @override
  Future<List<ProjectTechnologyStackEntity>>
      fetchProjectTechnologiesStack() async {
    final String jsonString = await rootBundle.loadString(
      AppConstants.technologiesStackListJson,
    );
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    final List<ProjectTechnologyStackEntity> technologies =
        <ProjectTechnologyStackEntity>[];

    for (final MapEntry<String, dynamic> categoryEntry in jsonData.entries) {
      final String category = categoryEntry.key;
      final List<dynamic> technologyList = categoryEntry.value as List<dynamic>;

      for (final dynamic item in technologyList) {
        technologies.add(
          ProjectTechnologyStackEntity(
            category: category,
            name: item as String,
          ),
        );
      }
    }

    return technologies;
  }
}
