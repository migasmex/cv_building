import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:create_cv/create_cv.gm.dart';
import 'package:cv_details/cv_details.gm.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:home/home.gm.dart';
import 'package:navigation/navigation.dart';

import '../cubit/cv_request_cubit/cv_request_cubit.dart';
import '../utils/cv_generation_type.dart';
import '../widgets/add_cv_dialog_widget.dart';

@RoutePage()
class CvRequestPage extends StatelessWidget {
  final String? projectIdToReplace;
  final String? cvIdToChange;

  const CvRequestPage({
    super.key,
    @QueryParam('cvIdToChange') this.cvIdToChange,
    @QueryParam('projectIdToReplace') this.projectIdToReplace,
  });

  Future<void> _addCv(BuildContext context) async {
    final CvGenerationType? cvAddingMethod = await showDialog<CvGenerationType>(
      context: context,
      builder: (BuildContext dialogContext) {
        return const AddCvDialogWidget();
      },
    );

    if (!context.mounted) return;

    if (cvAddingMethod == CvGenerationType.basicCv) {
      await AutoRouter.of(context).replace(
        HomeRoute(
          canAddCvToRequest: true,
        ),
      );
    } else if (cvAddingMethod == CvGenerationType.newCv) {
      await AutoRouter.of(context).replace(
        CreateCvRoute(
          isCvForRequest: true,
        ),
      );
    }
  }

  void _onDeleteCvPressed(BuildContext context, CvModel cvModel) {
    context.read<CvRequestCubit>().deleteNewCvRequest(cvModel);
  }

  void _goBack(BuildContext context) {
    AutoRouter.of(context).replace(
      HomeRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);
    return BlocProvider<CvRequestCubit>(
      create: (BuildContext context) => CvRequestCubit(
        getCvRequestListUseCase: appLocator<GetCvRequestListUseCase>(),
        deleteCvFromRequestUseCase: appLocator<DeleteCvFromRequestUseCase>(),
        addCvForRequestUseCase: appLocator<AddCvForRequestUseCase>(),
        getCvUseCase: appLocator<GetCvUseCase>(),
        currentUserIdUseCase: appLocator<CurrentUserIdUseCase>(),
      ),
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                context.locale.cvForRequestList,
                style: AppFonts.cvCardText.copyWith(
                  fontSize: 26,
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () => _goBack(context),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.constraint150,
                vertical: AppDimens.constraint50,
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: AppDimens.padding20),
                  Expanded(
                    child: BlocBuilder<CvRequestCubit, CvRequestState>(
                      builder: (BuildContext context, CvRequestState state) {
                        switch (state.status) {
                          case CvRequestStateStatus.loading:
                            return Center(
                              child: CircularProgressIndicator(
                                color: colors.black,
                              ),
                            );

                          case CvRequestStateStatus.loaded:
                            if (state.allCvsRequest == null ||
                                state.allCvsRequest!.isEmpty) {
                              return Center(
                                child: Text(
                                  context.locale.noCVsFound,
                                  style: TextStyle(
                                    color: colors.black,
                                  ),
                                ),
                              );
                            }
                            return SingleChildScrollView(
                              child: Wrap(
                                spacing: AppDimens.padding12,
                                runSpacing: AppDimens.padding12,
                                children: state.allCvsRequest!.map(
                                  (CvModel cv) {
                                    return CvCard(
                                      cardButtonTitle:
                                          context.locale.viewDetails,
                                      cv: cv,
                                      deleteCv: (_) {
                                        _onDeleteCvPressed(context, cv);
                                      },
                                      onCvPressed: (CvModel cv) {
                                        AutoRouter.of(context).push(
                                          CvDetailsRoute(
                                            isCvForRequest: true,
                                            cvIdToChange: cvIdToChange,
                                            id: cv.id,
                                            projectIdToReplace:
                                                projectIdToReplace,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                            );

                          case CvRequestStateStatus.failure:
                            return Center(
                              child: Text(
                                state.errorText ??
                                    context.locale.someErrorOccurred,
                                style: TextStyle(
                                  color: colors.black,
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
            floatingActionButton: RoundAppButton(
              title: context.locale.addCV,
              colors: colors,
              onPressed: () => _addCv(context),
            ),
          );
        },
      ),
    );
  }
}
