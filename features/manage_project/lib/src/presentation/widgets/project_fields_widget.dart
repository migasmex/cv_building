import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:cv_details/cv_details.gm.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:project_details/project_details.gm.dart';

import '../cubit/managing_project_cubit/managing_project_cubit.dart';
import 'domains_list_widget.dart';
import 'responsibilities_selector_widget.dart';
import 'select_technology_stack_widget.dart';
import 'technology_selector_widget.dart';

class CreateProjectFieldsWidget extends StatefulWidget {
  final String? projectId;
  final String cvId;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController roleController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String> environmentList;
  final List<String> achievementList;

  const CreateProjectFieldsWidget({
    required this.projectId,
    required this.cvId,
    required this.titleController,
    required this.descriptionController,
    required this.roleController,
    required this.startDateController,
    required this.endDateController,
    required this.startDate,
    required this.endDate,
    required this.environmentList,
    required this.achievementList,
    super.key,
  });

  @override
  State<CreateProjectFieldsWidget> createState() =>
      _CreateProjectFieldsWidgetState();
}

class _CreateProjectFieldsWidgetState extends State<CreateProjectFieldsWidget> {
  late DateTime? startDate = widget.startDate;
  late DateTime? endDate = widget.endDate;
  late List<String> environmentList = widget.environmentList;
  late List<String> achievementList = widget.achievementList;

  bool get isFormValid => !(widget.titleController.text.isEmpty ||
      widget.descriptionController.text.isEmpty ||
      widget.roleController.text.isEmpty ||
      environmentList.isEmpty ||
      startDate == null ||
      endDate == null ||
      achievementList.isEmpty);

  void _manageProject(
    BuildContext context,
  ) {
    if (!isFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.locale.fillInEmptyFields,
          ),
        ),
      );
      return;
    }

    final String period = DateFormattingClass.createPeriodFromDates(
      startDate!,
      endDate!,
    );

    if (widget.projectId == null || widget.projectId!.isEmpty) {
      final ProjectModel projectModel = ProjectModel(
        cvId: widget.cvId,
        title: widget.titleController.text,
        description: widget.descriptionController.text,
        environment: environmentList,
        period: period,
        role: widget.roleController.text,
        achievementList: achievementList,
      );
      context.read<ManagingProjectCubit>().addProject(
            projectModel,
          );
      AutoRouter.of(context).replace(
        CvDetailsRoute(
          id: projectModel.cvId,
        ),
      );
    } else {
      final ProjectModel projectModel = ProjectModel(
        id: widget.projectId,
        cvId: widget.cvId,
        title: widget.titleController.text,
        description: widget.descriptionController.text,
        environment: environmentList,
        period: period,
        role: widget.roleController.text,
        achievementList: achievementList,
      );
      context.read<ManagingProjectCubit>().editProject(
            projectModel,
          );
      AutoRouter.of(context).replace(
        ProjectDetailsRoute(
          projectId: widget.projectId!,
        ),
      );
    }
  }

  final List<String> environmentSuggestions = <String>[
    //<TODO> suggestions
  ];

  void _onDateSelected(
    DateTime pickedDate,
  ) {
    setState(() {
      startDate = pickedDate;

      if (endDate != null && endDate!.isBefore(startDate!)) {
        endDate = null;
        widget.endDateController.clear();
      }
    });
  }

  void _showDomainsDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (
        BuildContext dialogContext,
      ) {
        return DomainsListWidget(
          titleController: widget.titleController,
          descriptionController: widget.descriptionController,
        );
      },
    );
  }

  void _selectDate(
    DateTime pickedDate,
  ) {
    setState(() {
      endDate = pickedDate;
    });
  }

  Future<void> _selectTechnology(BuildContext context) async {
    final String? selectedTechnology = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => TechnologiesSelectorWidget(),
    );
    if (selectedTechnology != null) {
      setState(() {
        final List<String> newTechnologies = selectedTechnology
            .split(',')
            .map(
              (String tech) => tech.trim(),
            )
            .toList();

        widget.environmentList.addAll(
          newTechnologies
              .where((String tech) => !widget.environmentList.contains(tech)),
        );
      });
    }
  }

  Future<void> _selectTechnologyStack(BuildContext context) async {
    final String? selectedTechnology = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return TechnologyStackSelectorWidget();
      },
    );

    if (selectedTechnology != null) {
      setState(() {
        widget.environmentList.clear();
        widget.environmentList.addAll(
          selectedTechnology
              .split(',')
              .map(
                (String tech) => tech.trim(),
              )
              .toList(),
        );
      });
    }
  }

  void _updateAchievements(List<String> selectedItems) {
    setState(() {
      achievementList = selectedItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              const SizedBox(
                height: AppDimens.padding20,
              ),
              AppTextFieldWidget(
                labelText: context.locale.enterTitle,
                controller: widget.titleController,
                width: AppDimens.constraint500,
              ),
              const SizedBox(
                height: AppDimens.padding20,
              ),
              AppTextFieldWidget(
                labelText: context.locale.enterDescription,
                controller: widget.descriptionController,
                width: AppDimens.constraint500,
              ),
              TextButton(
                onPressed: () => _showDomainsDialog(
                  context,
                ),
                child: Text(
                  context.locale.orAddFromExistingProjects,
                  style: AppFonts.appTextStyle.copyWith(
                    color: AppColors.of(context).blue,
                  ),
                ),
              ),
              const SizedBox(
                height: AppDimens.padding20,
              ),
              AppTextFieldWidget(
                labelText: context.locale.enterYourRole,
                controller: widget.roleController,
                width: AppDimens.constraint500,
              ),
              const SizedBox(
                height: AppDimens.padding20,
              ),
              DatePickerField(
                labelText: context.locale.projectStartDate,
                dateController: widget.startDateController,
                initialDate: startDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                onDateSelected: _onDateSelected,
              ),
              const SizedBox(
                height: AppDimens.padding20,
              ),
              DatePickerField(
                labelText: context.locale.projectEndDate,
                dateController: widget.endDateController,
                initialDate: endDate ?? DateTime.now(),
                firstDate: startDate ?? DateTime(2000),
                lastDate: DateTime.now(),
                onDateSelected: _selectDate,
              ),
              const SizedBox(
                height: AppDimens.padding20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.padding30,
                    vertical: AppDimens.padding15,
                  ),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(),
                  ),
                ),
                onPressed: () => _selectTechnologyStack(context),
                child: Text(
                  context.locale.selectTechnologySet,
                  style: AppFonts.appBoldTextStyle.copyWith(
                    fontSize: 16,
                    color: AppColors.of(context).black,
                  ),
                ),
              ),
              const SizedBox(
                height: AppDimens.padding20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.padding30,
                    vertical: AppDimens.padding15,
                  ),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(),
                  ),
                ),
                onPressed: () => _selectTechnology(context),
                child: Text(
                  context.locale.selectTechnology,
                  style: AppFonts.appBoldTextStyle.copyWith(
                    fontSize: 16,
                    color: AppColors.of(context).black,
                  ),
                ),
              ),
              const SizedBox(
                height: AppDimens.padding20,
              ),
              HintTextField(
                chosenSuggestions: environmentList,
                labelText: context.locale.enterEnvironment,
                suggestions: environmentSuggestions,
                onChipListChanged: (
                  List<String> chipList,
                ) {
                  environmentList = chipList;
                },
              ),
              const SizedBox(
                height: AppDimens.padding20,
              ),
              ResponsibilitiesSelectorWidget(
                onSelectionChanged: _updateAchievements,
              ),
              const SizedBox(
                height: AppDimens.padding20,
              ),
              HintTextField(
                chosenSuggestions: achievementList,
                labelText: context.locale.enterAchievements,
                onChipListChanged: (
                  List<String> chipList,
                ) {
                  achievementList = chipList;
                },
              ),
              const SizedBox(
                height: AppDimens.padding20,
              ),
              AppButton(
                buttonText:
                    widget.projectId == null || widget.projectId!.isEmpty
                        ? context.locale.createProject
                        : context.locale.editProject,
                buttonWidth: AppDimens.constraint500,
                buttonHeight: AppDimens.constraint50,
                onPressed: () => _manageProject(
                  context,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
