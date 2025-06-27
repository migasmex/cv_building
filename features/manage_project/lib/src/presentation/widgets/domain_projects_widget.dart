import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'domains_list_widget.dart';

class DomainProjectsWidget extends StatelessWidget {
  final List<ProjectReviewModel>? domainProjects;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const DomainProjectsWidget({
    required this.domainProjects,
    required this.titleController,
    required this.descriptionController,
    super.key,
  });

  Future<void> _chooseDomainProject(
    BuildContext context,
    ProjectReviewModel project,
  ) async {
    titleController.text = project.name;
    descriptionController.text = project.description;

    await AutoRouter.of(context).maybePop();
  }

  Future<void> _goBack(
    BuildContext context,
  ) async {
    await AutoRouter.of(context).maybePop();
  }

  Future<void> _showDomains(
    BuildContext context,
  ) async {
    await AutoRouter.of(context).maybePop();

    if (!context.mounted) return;

    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return DomainsListWidget(
          titleController: titleController,
          descriptionController: descriptionController,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.locale.selectProject,
        style: TextStyle(
          color: AppColors.of(context).black,
        ),
      ),
      content: domainProjects == null
          ? Center(
              child: Text(
                context.locale.noDomainsFound,
                style: AppFonts.appTextStyle.copyWith(
                  color: AppColors.of(context).black,
                ),
              ),
            )
          : SizedBox(
              width: AppDimens.constraint500,
              height: AppDimens.constraint500,
              child: ListView.builder(
                itemCount: domainProjects!.length,
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  final ProjectReviewModel project = domainProjects![index];

                  return ListTile(
                    title: Text(
                      project.name,
                    ),
                    subtitle: Text(
                      project.description,
                    ),
                    onTap: () => _chooseDomainProject(
                      context,
                      project,
                    ),
                  );
                },
              ),
            ),
      actions: <Widget>[
        TextButton(
          onPressed: () => _goBack(context),
          child: Text(
            context.locale.back,
            style: TextStyle(
              color: AppColors.of(context).black,
            ),
          ),
        ),
        TextButton(
          onPressed: () => _showDomains(context),
          child: Text(
            context.locale.domains,
            style: TextStyle(
              color: AppColors.of(context).black,
            ),
          ),
        ),
      ],
    );
  }
}
