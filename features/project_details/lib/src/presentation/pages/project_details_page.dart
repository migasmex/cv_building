import 'package:core/core.dart';
import 'package:core/generated/l10n.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../cubit/project_details_cubit.dart';
import '../widgets/project_details_content_widget.dart';

@RoutePage()
class ProjectDetailsPage extends StatelessWidget {
  final String projectId;

  const ProjectDetailsPage({
    Key? key,
    @PathParam('projectId') required this.projectId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);
    final AppLocalization locale = context.locale;

    return BlocProvider<ProjectDetailsCubit>(
      create: (BuildContext context) => ProjectDetailsCubit(
        getProjectUseCase: appLocator<GetProjectUseCase>(),
        id: projectId,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              locale.projectDetails,
            ),
          ),
        ),
        body: BlocBuilder<ProjectDetailsCubit, ProjectDetailsState>(
          builder: (BuildContext context, ProjectDetailsState state) {
            switch (state.status) {
              case ProjectDetailsStateStatus.loading:
                return Center(
                  child: CircularProgressIndicator(
                    color: colors.black,
                  ),
                );

              case ProjectDetailsStateStatus.loaded:
                final ProjectModel? project = state.project;

                if (project == null) {
                  return Center(
                    child: Text(
                      locale.noProjectsFound,
                    ),
                  );
                }

                return ProjectDetailsContentWidget(
                  project: project,
                );

              case ProjectDetailsStateStatus.failure:
                return Center(
                  child: Text(
                    state.errorText ?? locale.someErrorOccurred,
                    style: TextStyle(
                      color: colors.black,
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
