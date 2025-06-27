import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../utils/project_generation_type.dart';

class AddProjectDialogWidget extends StatelessWidget {
  const AddProjectDialogWidget({super.key});

  void _createNewProject(BuildContext context) {
    AutoRouter.of(context).maybePop(
      ProjectGenerationType.createNew,
    );
  }

  void _chooseExistingProject(BuildContext context) {
    AutoRouter.of(context).maybePop(
      ProjectGenerationType.chooseExisting,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.locale.addProject,
        style: TextStyle(
          color: AppColors.of(context).black,
        ),
      ),
      content: Text(
        context.locale.chooseAnOptionToAddProject,
        style: TextStyle(
          color: AppColors.of(context).black,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            _createNewProject(context);
          },
          child: Text(
            context.locale.createNewProject,
            style: TextStyle(
              color: AppColors.of(context).black,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            _chooseExistingProject(context);
          },
          child: Text(
            context.locale.addFromExisting,
            style: TextStyle(
              color: AppColors.of(context).black,
            ),
          ),
        ),
      ],
    );
  }
}
