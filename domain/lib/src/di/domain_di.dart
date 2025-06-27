import 'package:core/core.dart';

import '../../domain.dart';
import '../use_cases/project_use_cases/fetch_project_technologies_stack_use_case.dart';

abstract class DomainDI {
  static void initDependencies(GetIt locator) {
    _initUseCases(locator);
  }

  static void _initUseCases(GetIt locator) {
    locator.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(
        authRepository: locator<AuthRepository>(),
      ),
    );

    locator.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(
        authRepository: locator<AuthRepository>(),
      ),
    );

    locator.registerLazySingleton<IsUserAuthorizedUseCase>(
      () => IsUserAuthorizedUseCase(
        authRepository: locator<AuthRepository>(),
      ),
    );

    locator.registerFactory<CurrentUserIdUseCase>(
      () => CurrentUserIdUseCase(
        authRepository: locator<AuthRepository>(),
      ),
    );

    locator.registerLazySingleton<AddProjectUseCase>(
      () => AddProjectUseCase(projectRepository: locator<ProjectRepository>()),
    );

    locator.registerFactory<UpdateProjectUseCase>(
      () => UpdateProjectUseCase(
        projectRepository: locator<ProjectRepository>(),
      ),
    );

    locator.registerLazySingleton<GetProjectUseCase>(
      () => GetProjectUseCase(projectRepository: locator<ProjectRepository>()),
    );

    locator.registerFactory<GetDomainsUseCase>(
      () => GetDomainsUseCase(
        projectRepository: locator<ProjectRepository>(),
      ),
    );

    locator.registerFactory<GetDomainProjectsUseCase>(
      () => GetDomainProjectsUseCase(
        projectRepository: locator<ProjectRepository>(),
      ),
    );

    locator.registerLazySingleton<DeleteProjectUseCase>(
      () =>
          DeleteProjectUseCase(projectRepository: locator<ProjectRepository>()),
    );

    locator.registerLazySingleton<DeleteCvUseCase>(
      () => DeleteCvUseCase(cvRepository: locator<CvRepository>()),
    );

    locator.registerLazySingleton<GetCvUseCase>(
      () => GetCvUseCase(cvRepository: locator<CvRepository>()),
    );

    locator.registerLazySingleton<GetAllCvsUseCase>(
      () => GetAllCvsUseCase(cvRepository: locator<CvRepository>()),
    );

    locator.registerLazySingleton<AddCvUseCase>(
      () => AddCvUseCase(cvRepository: locator<CvRepository>()),
    );

    locator.registerLazySingleton<GetAllProjectsByCvIdUseCase>(
      () => GetAllProjectsByCvIdUseCase(
        projectRepository: locator<ProjectRepository>(),
      ),
    );

    locator.registerFactory<GetCvRequestListUseCase>(
      () => GetCvRequestListUseCase(
        cvRequestRepository: locator<CvRequestRepository>(),
        cvRepository: locator<CvRepository>(),
      ),
    );

    locator.registerFactory<AddCvForRequestUseCase>(
      () => AddCvForRequestUseCase(
        cvRequestRepository: locator<CvRequestRepository>(),
      ),
    );

    locator.registerFactory<AddCvRequestUseCase>(
      () => AddCvRequestUseCase(
        cvRequestRepository: locator<CvRequestRepository>(),
      ),
    );

    locator.registerFactory<DeleteCvFromRequestUseCase>(
      () => DeleteCvFromRequestUseCase(
        cvRequestRepository: locator<CvRequestRepository>(),
      ),
    );

    locator.registerLazySingleton<ExportToDocxService>(
      () => ExportToDocxService(
        remoteConfigService: locator<RemoteConfigService>(),
      ),
    );

    locator.registerLazySingleton<ExportToPdfService>(
      () => ExportToPdfService(
        remoteConfigService: locator<RemoteConfigService>(),
      ),
    );

    locator.registerFactory<FetchLanguagesUseCase>(
      () => FetchLanguagesUseCase(
        projectRepository: locator<ProjectRepository>(),
      ),
    );

    locator.registerFactory<FetchCategoriesUseCase>(
      () => FetchCategoriesUseCase(
        projectRepository: locator<ProjectRepository>(),
      ),
    );

    locator.registerFactory<FetchProjectTechnologiesUseCase>(
      () => FetchProjectTechnologiesUseCase(
        projectRepository: locator<ProjectRepository>(),
      ),
    );

    locator.registerFactory<FetchProjectTechnologiesStackUseCase>(
      () => FetchProjectTechnologiesStackUseCase(
        projectRepository: locator<ProjectRepository>(),
      ),
    );
  }
}
