import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'project_card_widget.dart';

class ProjectListWidget extends StatefulWidget {
  final String? cvIdToChange;
  final String? projectIdToReplace;
  final String cvId;
  final List<ProjectModel> projects;

  const ProjectListWidget({
    required this.cvIdToChange,
    required this.projectIdToReplace,
    required this.cvId,
    required this.projects,
    super.key,
  });

  @override
  State<ProjectListWidget> createState() => _ProjectsListState();
}

class _ProjectsListState extends State<ProjectListWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverReorderableList(
      itemBuilder: (BuildContext context, int index) {
        final ProjectModel project = widget.projects[index];

        return ReorderableDragStartListener(
          key: ValueKey<ProjectModel>(project),
          index: index,
          child: ProjectCardWidget(
            cvIdToChange: widget.cvIdToChange,
            projectIdToReplace: widget.projectIdToReplace,
            cvId: widget.cvId,
            project: project,
          ),
        );
      },
      onReorder: _reorderProjects,
      itemCount: widget.projects.length,
    );
  }

  void _reorderProjects(int oldIndex, int newIndex) {
    int targetIndex = newIndex;

    if (newIndex > oldIndex) {
      targetIndex -= 1;
    }

    setState(() {
      final ProjectModel item = widget.projects.removeAt(oldIndex);
      widget.projects.insert(targetIndex, item);
    });
  }
}
