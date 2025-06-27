import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:create_cv/create_cv.gm.dart';
import 'package:cv_details/cv_details.gm.dart';
import 'package:cv_request/cv_request.gm.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:home/home.gm.dart';
import 'package:navigation/navigation.dart';

import '../blocs/cubit/cv_folder_cubit.dart';
import '../utils/filters.dart';
import '../widgets/filter_widgets/filters_widget.dart';

@RoutePage()
class CvPage extends StatelessWidget {
  final String folderName;
  final String? domains;
  final double? experienceInYears;
  final String? cvId;
  final String? projectIdToReplace;
  final bool? canAddCvToRequest;

  const CvPage({
    super.key,
    @PathParam('folderName') this.folderName = '',
    @QueryParam('domains') this.domains,
    @QueryParam('experienceInYears') this.experienceInYears,
    @QueryParam('cvId') this.cvId,
    @QueryParam('projectIdToReplace') this.projectIdToReplace,
    @QueryParam('canAddCvToRequest') this.canAddCvToRequest,
  });

  bool get canShowAddButton => cvId == null && canAddCvToRequest == null;

  void _openCvCreatePage(BuildContext context) {
    AutoRouter.of(context).replace(
      CreateCvRoute(
        folderName: folderName,
      ),
    );
  }

  Future<void> _onCvPressed(BuildContext context, CvModel cv) async {
    if (canAddCvToRequest != null) {
      final CvFolderCubit cvFolderCubit =
          BlocProvider.of<CvFolderCubit>(context);

      await cvFolderCubit.addNewCvRequest(cv);

      if (!context.mounted) return;

      await AutoRouter.of(context).replace(
        CvRequestRoute(),
      );

      return;
    }

    final CvDetailsRoute route = CvDetailsRoute(
      cvIdToChange: cvId,
      id: cv.id,
      projectIdToReplace: projectIdToReplace,
      folderName: folderName,
    );

    if (cvId != null || projectIdToReplace != null) {
      await AutoRouter.of(context).replace(route);
    }

    if (context.mounted) {
      await AutoRouter.of(context).push(route);
    }
  }

  String _getCardButtonTitle(BuildContext context) {
    if (canAddCvToRequest == null && cvId != null) {
      return context.locale.chooseCV;
    } else if (canAddCvToRequest != null && cvId == null) {
      return context.locale.chooseCV;
    } else if (canAddCvToRequest == null && cvId == null) {
      return context.locale.viewDetails;
    }
    return context.locale.viewDetails;
  }

  void _goBack(BuildContext context) {
    PageRouteInfo<dynamic> route;

    if (canAddCvToRequest != null) {
      route = HomeRoute(
        canAddCvToRequest: true,
      );
    } else if (cvId != null) {
      route = HomeRoute(
        folderName: folderName,
        cvId: cvId,
      );
    } else {
      route = HomeRoute(
        cvId: cvId,
      );
    }

    AutoRouter.of(context).replace(
      route,
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    final List<String>? domainList = domains?.split(',');

    final Filters filters = Filters(
      domains: domainList,
      experienceInYears: experienceInYears,
    );

    return BlocProvider<CvFolderCubit>(
      create: (BuildContext context) => CvFolderCubit(
        getAllCvsUseCase: appLocator<GetAllCvsUseCase>(),
        addCvForRequestUseCase: appLocator<AddCvForRequestUseCase>(),
        currentUserIdUseCase: appLocator<CurrentUserIdUseCase>(),
        folderName: folderName,
        domains: domainList,
        experienceInYears: experienceInYears,
      ),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          backgroundColor: colors.white,
          appBar: AppBar(
            actions: <Widget>[
              canShowAddButton
                  ? IconButton(
                      onPressed: () => _openCvCreatePage(context),
                      icon: const Icon(
                        Icons.add,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () => _goBack(context),
            ),
            centerTitle: true,
            title: Text(
              context.locale.cvList,
              style: AppFonts.cvCardText.copyWith(
                fontSize: 26,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.constraint150,
              vertical: AppDimens.constraint50,
            ),
            child: Column(
              children: <Widget>[
                FiltersWidget(
                  folderName: folderName,
                  filters: filters,
                ),
                const SizedBox(
                  height: AppDimens.padding12,
                ),
                Expanded(
                  child: BlocBuilder<CvFolderCubit, CvFolderState>(
                    builder: (BuildContext context, CvFolderState state) {
                      switch (state.status) {
                        case CvFolderStateStatus.loading:
                          return Center(
                            child: CircularProgressIndicator(
                              color: colors.black,
                            ),
                          );

                        case CvFolderStateStatus.loaded:
                          if (state.filteredCvs == null ||
                              state.filteredCvs!.isEmpty) {
                            return Center(
                              child: Text(
                                context.locale.noCVsFound,
                                style: TextStyle(
                                  color: AppColors.of(context).black,
                                ),
                              ),
                            );
                          } else {
                            return SingleChildScrollView(
                              child: Wrap(
                                children: state.filteredCvs!.map(
                                  (CvModel cv) {
                                    return CvCard(
                                      cardButtonTitle:
                                          _getCardButtonTitle(context),
                                      onCvPressed: (CvModel cv) =>
                                          _onCvPressed(context, cv),
                                      cv: cv,
                                    );
                                  },
                                ).toList(),
                              ),
                            );
                          }

                        case CvFolderStateStatus.failure:
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
