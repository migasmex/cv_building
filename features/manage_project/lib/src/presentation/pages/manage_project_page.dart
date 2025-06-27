import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../cubit/managing_project_cubit/managing_project_cubit.dart';
import '../widgets/project_fields_widget.dart';

@RoutePage()
class ManageProjectPage extends StatefulWidget {
  final String cvId;
  final String? projectId;

  const ManageProjectPage({
    @QueryParam('projectId') this.projectId,
    @PathParam('cvId') required this.cvId,
  });

  @override
  _ManageProjectPageState createState() => _ManageProjectPageState();
}

class _ManageProjectPageState extends State<ManageProjectPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _roleController;
  late final TextEditingController _startDateController;
  late final TextEditingController _endDateController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _roleController = TextEditingController();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    super.initState();
  }

  DateTime? startDate;
  DateTime? endDate;
  List<String> environmentList = <String>[];
  List<String> achievementList = <String>[];

  void _initializeProjectData(
    ProjectModel project,
  ) {
    _titleController.text = project.title;
    _descriptionController.text = project.description;
    _roleController.text = project.role;

    final List<DateTime> periodDates = DateFormattingClass.parsePeriodToDates(
      project.period,
    );

    setState(() {
      startDate = periodDates[0];
      endDate = periodDates[1];
      _startDateController.text = DateFormattingClass.formatDate(
        startDate!,
      );
      _endDateController.text = DateFormattingClass.formatDate(
        endDate!,
      );
      environmentList = project.environment;
      achievementList = project.achievementList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManagingProjectCubit>(
      create: (_) => ManagingProjectCubit(
        getProjectUseCase: appLocator<GetProjectUseCase>(),
        addProjectUseCase: appLocator<AddProjectUseCase>(),
        updateProjectUseCase: appLocator<UpdateProjectUseCase>(),
        projectId: widget.projectId,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              context.locale.createProject,
            ),
          ),
          backgroundColor: AppColors.of(context).white,
        ),
        backgroundColor: AppColors.of(context).white,
        body: BlocListener<ManagingProjectCubit, ManagingProjectState>(
          listener: (
            BuildContext context,
            ManagingProjectState state,
          ) {
            if (widget.projectId != null &&
                widget.projectId!.isNotEmpty &&
                state.project != null) {
              _initializeProjectData(
                state.project!,
              );
            }
          },
          child: CreateProjectFieldsWidget(
            startDate: startDate,
            endDate: endDate,
            environmentList: environmentList,
            achievementList: achievementList,
            titleController: _titleController,
            descriptionController: _descriptionController,
            roleController: _roleController,
            startDateController: _startDateController,
            endDateController: _endDateController,
            projectId: widget.projectId,
            cvId: widget.cvId,
          ),
        ),
      ),
    );
  }
}
