import 'package:authentication/authentication.gm.dart';
import 'package:auto_route/auto_route.dart';
import 'package:create_cv/create_cv.dart';
import 'package:create_cv/create_cv.gm.dart';
import 'package:cv/cv.dart';
import 'package:cv/cv.gm.dart';
import 'package:cv_details/cv_details.dart';
import 'package:cv_details/cv_details.gm.dart';
import 'package:cv_request/cv_request.dart';
import 'package:cv_request/cv_request.gm.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:home/home.dart';
import 'package:home/home.gm.dart';
import 'package:manage_project/manage_project.dart';
import 'package:manage_project/manage_project.gm.dart';
import 'package:project_details/project_details.dart';
import 'package:project_details/project_details.gm.dart';

import '../guards/auth_guard.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  modules: <Type>[
    AuthenticationModule,
    HomeModule,
    CreateCvModule,
    CvModule,
    CvDetailsModule,
    CvRequestModule,
    ProjectDetailsModule,
    ManageProjectModule,
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter({
    required this.isUserAuthorizedUseCase,
  });

  final IsUserAuthorizedUseCase isUserAuthorizedUseCase;

  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          initial: true,
          page: HomeRoute.page,
          path: '/home',
          guards: <AutoRouteGuard>[
            if (kReleaseMode) AuthGuard(isUserAuthorizedUseCase),
          ],
        ),
        AutoRoute(
          page: SignInRoute.page,
          path: '/sign_in',
        ),
        AutoRoute(
          page: ManageProjectRoute.page,
          path: '/create_project/:cvId',
          guards: <AutoRouteGuard>[
            if (kReleaseMode) AuthGuard(isUserAuthorizedUseCase),
          ],
        ),
        AutoRoute(
          page: CreateCvRoute.page,
          path: '/create_cv',
          guards: <AutoRouteGuard>[
            if (kReleaseMode) AuthGuard(isUserAuthorizedUseCase),
          ],
        ),
        AutoRoute(
          page: CvRoute.page,
          path: '/cv_page/:folderName',
          guards: <AutoRouteGuard>[
            if (kReleaseMode) AuthGuard(isUserAuthorizedUseCase),
          ],
        ),
        AutoRoute(
          page: SplashRoute.page,
          path: '/splash_page',
        ),
        AutoRoute(
          page: CvDetailsRoute.page,
          path: '/cv_details_page/:cvId',
          guards: <AutoRouteGuard>[
            if (kReleaseMode) AuthGuard(isUserAuthorizedUseCase),
          ],
        ),
        AutoRoute(
          page: CvRequestRoute.page,
          path: '/cv_request_page',
          guards: <AutoRouteGuard>[
            if (kReleaseMode) AuthGuard(isUserAuthorizedUseCase),
          ],
        ),
        AutoRoute(
          page: ProjectDetailsRoute.page,
          path: '/project_details_page/:projectId',
          guards: <AutoRouteGuard>[
            if (kReleaseMode) AuthGuard(isUserAuthorizedUseCase),
          ],
        ),
      ];
}
