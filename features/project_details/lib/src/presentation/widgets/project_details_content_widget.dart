import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'project_details_card_widget.dart';

class ProjectDetailsContentWidget extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailsContentWidget({
    required this.project,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(
        AppDimens.padding16,
      ),
      children: <Widget>[
        ProjectDetailsCardWidget(
          project: project,
        ),
      ],
    );
  }
}
