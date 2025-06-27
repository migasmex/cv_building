import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class ProjectTile extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback? onTap;
  final VoidCallback? replaceProject;
  final bool canChooseProject;

  const ProjectTile({
    super.key,
    required this.project,
    required this.canChooseProject,
    this.onTap,
    this.replaceProject,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);
    return InkWell(
      onTap: onTap,
      child: ListTile(
        contentPadding: const EdgeInsets.all(
          AppDimens.padding16,
        ),
        title: Text(
          project.title,
          style: AppFonts.cvCardText,
        ),
        subtitle: Text(
          project.role,
          style: AppFonts.cvCardText.copyWith(
            color: colors.gray,
          ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.all(
            AppDimens.padding10,
          ),
          child: IconButton(
            icon: !canChooseProject
                ? Icon(
                    Icons.find_replace,
                    color: colors.black,
                  )
                : const SizedBox.shrink(),
            onPressed: replaceProject,
          ),
        ),
      ),
    );
  }
}
