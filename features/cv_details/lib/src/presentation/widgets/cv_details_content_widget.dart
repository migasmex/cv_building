import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'cv_details_header_widget.dart';
import 'export_buttons_widget.dart';
import 'project_list_widget.dart';

class CvDetailsContentWidget extends StatelessWidget {
  final CvModel cv;
  final List<ProjectModel> projects;
  final String? cvIdToChange;
  final String? projectIdToReplace;

  const CvDetailsContentWidget({
    required this.cv,
    required this.projects,
    required this.cvIdToChange,
    required this.projectIdToReplace,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppDimens.constraint800,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  if (cvIdToChange == null)
                    CvDetailsHeaderWidget(
                      projects: projects,
                      cv: cv,
                    ),
                  if (projects.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(
                        AppDimens.padding100,
                      ),
                      child: Center(
                        child: Text(
                          context.locale.noProjectsFound,
                          style: TextStyle(
                            color: AppColors.of(context).black,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (projects.isNotEmpty)
              ProjectListWidget(
                cvId: cv.id,
                cvIdToChange: cvIdToChange,
                projectIdToReplace: projectIdToReplace,
                projects: projects,
              ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  if (cvIdToChange == null)
                    ExportButtonsWidget(
                      cv: cv,
                      projects: projects,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
