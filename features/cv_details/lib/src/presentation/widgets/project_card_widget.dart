import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:home/home.gm.dart';
import 'package:navigation/navigation.dart';
import 'package:project_details/project_details.gm.dart';

import '../../../cv_details.gm.dart';
import '../blocs/cv_details_cubit/cv_details_cubit.dart';
import 'project_tile.dart';

class ProjectCardWidget extends StatelessWidget {
  final String? cvIdToChange;
  final String? projectIdToReplace;
  final String cvId;
  final ProjectModel project;

  const ProjectCardWidget({
    required this.cvId,
    required this.project,
    required this.cvIdToChange,
    required this.projectIdToReplace,
    super.key,
  });

  Future<void> _handleProjectAction(BuildContext context) async {
    if (projectIdToReplace != null && cvIdToChange != null) {
      return _replaceProject(context);

    } else if (cvIdToChange != null && projectIdToReplace == null) {
      return _addProject(context);
    }

    await AutoRouter.of(context).push(
      ProjectDetailsRoute(
        projectId: project.id!,
      ),
    );
  }

  Future<void> _addProject(BuildContext context) async {
    final CvDetailsCubit cvDetailsCubit =
        BlocProvider.of<CvDetailsCubit>(context);

    await cvDetailsCubit.addProjectToCv(
      project,
      cvIdToChange!,
    );

    if (!context.mounted) return;

    await AutoRouter.of(context).replace(
      CvDetailsRoute(
        id: cvIdToChange!,
        key: UniqueKey(),
      ),
    );

    return;
  }

  Future<void> _replaceProject(BuildContext context) async {
    final CvDetailsCubit cvDetailsCubit =
        BlocProvider.of<CvDetailsCubit>(context);

    final String period =
        await cvDetailsCubit.getProjectPeriod(projectIdToReplace!);
    final ProjectModel replacedProject = ProjectModel(
      cvId: project.cvId,
      title: project.title,
      description: project.description,
      role: project.role,
      period: period,
      environment: project.environment,
      achievementList: project.achievementList,
    );

    await cvDetailsCubit.deleteProjectFromCv(projectIdToReplace!);

    await cvDetailsCubit.addProjectToCv(
      replacedProject,
      cvIdToChange!,
    );

    if (!context.mounted) return;

    await AutoRouter.of(context).replace(
      CvDetailsRoute(
        id: cvIdToChange!,
        key: UniqueKey(),
      ),
    );

    return;
  }

  Future<void> _replaceWithExistingProject(BuildContext context) async {
    await AutoRouter.of(context).replace(
      HomeRoute(
        projectIdToReplace: project.id,
        cvId: project.cvId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.of(context).whiteCard,
      child: ProjectTile(
        project: project,
        canChooseProject: cvIdToChange != null && cvIdToChange!.isNotEmpty,
        onTap: () => _handleProjectAction(context),
        replaceProject: () => _replaceWithExistingProject(context),
      ),
    );
  }
}
