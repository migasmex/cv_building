import 'package:core/core.dart';
import 'package:core/generated/l10n.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:manage_project/manage_project.gm.dart';
import 'package:navigation/navigation.dart';

import 'achievements_section_widget.dart';
import 'project_section_widget.dart';

class ProjectDetailsCardWidget extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailsCardWidget({
    required this.project,
    super.key,
  });

  void _openEditProjectPage(BuildContext context) {
    AutoRouter.of(context).replace(
      ManageProjectRoute(
        cvId: project.cvId,
        projectId: project.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);
    final AppLocalization locale = context.locale;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimens.borderRadius12,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          AppDimens.padding16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              project.title,
              style: AppFonts.appBoldTextStyle.copyWith(
                color: colors.black,
              ),
            ),
            const SizedBox(
              height: AppDimens.padding10,
            ),
            Text(
              project.description,
              style: AppFonts.appTextStyle.copyWith(
                color: colors.black,
              ),
            ),
            const SizedBox(
              height: AppDimens.padding30,
            ),
            ProjectSectionWidget(
              title: locale.projectRole,
              content: project.role,
            ),
            ProjectSectionWidget(
              title: locale.period,
              content: project.period,
            ),
            const SizedBox(
              height: AppDimens.padding30,
            ),
            AchievementsSectionWidget(
              achievements: project.achievementList,
            ),
            const SizedBox(
              height: AppDimens.padding30,
            ),
            ProjectSectionWidget(
              title: locale.environment,
              content: project.environment.join(', '),
            ),
            AppButton(
              buttonText: context.locale.editProject,
              buttonHeight: AppDimens.constraint50,
              buttonWidth: double.infinity,
              onPressed: () => _openEditProjectPage(context),
            ),
          ],
        ),
      ),
    );
  }
}
