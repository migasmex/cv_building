import 'package:authentication/authentication.gm.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:cv/cv.gm.dart';
import 'package:cv_details/cv_details.gm.dart';
import 'package:cv_request/cv_request.gm.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../blocs/cv_cubit/cv_cubit.dart';
import '../blocs/logout_bloc/logout_bloc.dart';
import '../widgets/folder_card_widget.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  final String? cvId;
  final String? projectIdToReplace;
  final bool? canAddCvToRequest;
  final String? folderName;

  const HomePage({
    Key? key,
    @QueryParam('cvId') this.cvId,
    @QueryParam('projectIdToReplace') this.projectIdToReplace,
    @QueryParam('canAddCvToRequest') this.canAddCvToRequest,
    @QueryParam('folderName') this.folderName,
  }) : super(key: key);

  bool get canShowBackButton =>
      !(folderName == null && cvId == null && canAddCvToRequest == null);

  void _logout(BuildContext context) {
    context.read<LogoutBloc>().add(
          LogoutRequestedEvent(),
        );
    AutoRouter.of(context).replace(
      const SignInRoute(),
    );
  }

  Future<void> _openCvRequest(BuildContext context) async {
    await BlocProvider.of<CvCubit>(context).addRequestForUser();

    if (!context.mounted) return;

    await AutoRouter.of(context).push(
      CvRequestRoute(),
    );
  }

  Future<void> _openFolder(String folder, BuildContext context) async {
    final StackRouter autoRouter = AutoRouter.of(context);

    final CvRoute route = CvRoute(
      cvId: cvId,
      folderName: folder,
      projectIdToReplace: projectIdToReplace,
      canAddCvToRequest: canAddCvToRequest,
    );

    if (canAddCvToRequest != null ||
        cvId != null ||
        projectIdToReplace != null) {
      await autoRouter.replace(route);
    }

    if (context.mounted) {
      await autoRouter.push(route);
    }
  }

  void _goBack(BuildContext context) {
    PageRouteInfo<dynamic> route;

    if (canAddCvToRequest != null) {
      route = CvRequestRoute();
    } else {
      route = CvDetailsRoute(
        id: cvId!,
      );
    }

    AutoRouter.of(context).replace(
      route,
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);
    return BlocProvider<CvCubit>(
      create: (BuildContext context) => CvCubit(
        getAllCvsUseCase: appLocator<GetAllCvsUseCase>(),
        addCvRequestUseCase: appLocator<AddCvRequestUseCase>(),
        currentUserIdUseCase: appLocator<CurrentUserIdUseCase>(),
      ),
      child: Scaffold(
        backgroundColor: AppColors.of(context).white,
        appBar: AppBar(
          backgroundColor: AppColors.of(context).white,
          automaticallyImplyLeading: false,
          leading: canShowBackButton
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () => _goBack(context),
                )
              : null,
          title: Center(
            child: Text(
              context.locale.home,
            ),
          ),
          actions: <Widget>[
            BlocProvider<LogoutBloc>(
              create: (BuildContext context) => LogoutBloc(
                logoutUseCase: appLocator<LogoutUseCase>(),
              ),
              child: Builder(
                builder: (BuildContext localContext) => IconButton(
                  icon: const Icon(
                    Icons.logout,
                  ),
                  onPressed: () {
                    _logout(localContext);
                  },
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<CvCubit, CvState>(
          builder: (BuildContext context, CvState state) {
            switch (state.status) {
              case CvStateStatus.loading:
                return Center(
                  child: CircularProgressIndicator(
                    color: colors.black,
                  ),
                );

              case CvStateStatus.loaded:
                final List<String> folders =
                    context.read<CvCubit>().generateCvFolders();

                return Center(
                  child: Column(
                    children: <Widget>[
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Wrap(
                          spacing: AppDimens.padding12,
                          runSpacing: AppDimens.padding12,
                          children: folders.map(
                            (String folder) {
                              return InkWell(
                                onTap: () => _openFolder(folder, context),
                                child: SizedBox(
                                  width: AppDimens.constraint300,
                                  height: AppDimens.constraint50,
                                  child: FolderCardWidget(
                                    title: folder,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                );

              case CvStateStatus.failure:
                return Center(
                  child: Text(
                    state.errorText ?? context.locale.cvLoadingError,
                    style: TextStyle(
                      color: AppColors.of(context).black,
                    ),
                  ),
                );
            }
          },
        ),
        floatingActionButton: Builder(
          builder: (BuildContext localContext) {
            if (canAddCvToRequest == null && cvId == null) {
              return RoundAppButton(
                title: context.locale.cvRequest,
                colors: AppColors.of(context),
                onPressed: () => _openCvRequest(localContext),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
