import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import '../../data.dart';
import '../config/remote_config_wrapper.dart';
import '../providers/auth_firebase_provider_impl.dart';
import '../providers/cv_firestore_provider_impl.dart';
import '../providers/cv_request_provider_impl.dart';
import '../providers/project_firestore_provider_impl.dart';
import '../repositories/auth_repository_impl.dart';
import '../repositories/cv_request_repository_impl.dart';

abstract class DataDI {
  static Future<void> initDependencies(GetIt locator) async {
    _initApi(locator);
    await _initProviders(locator);
    _initRepositories(locator);
  }

  static void _initApi(GetIt locator) {
    locator.registerLazySingleton<DioConfig>(
      () => DioConfig(
        appConfig: locator<AppConfig>(),
      ),
    );

    locator.registerLazySingleton<ErrorHandler>(
      () => ErrorHandler(
        eventNotifier: locator<AppEventNotifier>(),
      ),
    );

    locator.registerLazySingleton<ApiProvider>(
      () => ApiProvider(
        locator<DioConfig>().dio,
      ),
    );
  }

  static Future<void> _initProviders(GetIt locator) async {
    locator.registerLazySingleton<AuthFirebaseProviderImpl>(
      AuthFirebaseProviderImpl.new,
    );

    locator.registerLazySingleton<CvProvider>(
      () => CvFirestoreProviderImpl(firestore: FirebaseFirestore.instance),
    );

    await FirebaseRemoteConfig.instance.fetchAndActivate();

    locator.registerLazySingleton<RemoteConfigWrapper>(
      () => RemoteConfigWrapper(remoteConfig: FirebaseRemoteConfig.instance),
    );

    locator.registerLazySingleton<RemoteConfigService>(
      () => RemoteConfigServiceImpl(
        configWrapper: locator<RemoteConfigWrapper>(),
      ),
    );

    locator.registerLazySingleton<ProjectRemoteDatasourceProvider>(
      () => ProjectFirestoreProviderImpl(firestore: FirebaseFirestore.instance),
    );

    locator.registerFactory<CvRequestProvider>(
      () => CvRequestProviderImpl(
        cvProvider: locator<CvProvider>(),
      ),
    );
  }

  static void _initRepositories(GetIt locator) {
    locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authFirebaseProvider: locator<AuthFirebaseProviderImpl>(),
      ),
    );

    locator.registerLazySingleton<ProjectRepository>(
      () => ProjectRepositoryImpl(
        firestoreProvider: locator<ProjectRemoteDatasourceProvider>(),
      ),
    );

    locator.registerLazySingleton<CvRepository>(
      () => CvRepositoryImpl(firestoreProvider: locator<CvProvider>()),
    );

    locator.registerLazySingleton<CvRequestRepository>(
      () => CvRequestRepositoryImpl(
        cvRequestProvider: locator<CvRequestProvider>(),
      ),
    );
  }
}
