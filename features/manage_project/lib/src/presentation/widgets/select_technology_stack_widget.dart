import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../cubit/project_technologies_stack_cubit/project_technologies_stack_cubit.dart';
import 'technology_stack_list.dart';

class TechnologyStackSelectorWidget extends StatefulWidget {
  @override
  _TechnologyStackSelectorWidgetState createState() =>
      _TechnologyStackSelectorWidgetState();
}

class _TechnologyStackSelectorWidgetState
    extends State<TechnologyStackSelectorWidget> {
  String? _selectedCategory;

  Map<String, List<String>> _groupTechnologiesByCategory(
    List<ProjectTechnologyStackModel> technologies,
  ) {
    final Map<String, List<String>> grouped = <String, List<String>>{};

    for (final ProjectTechnologyStackModel tech in technologies) {
      if (!grouped.containsKey(tech.category)) {
        grouped[tech.category] = <String>[];
      }
      grouped[tech.category]!.add(tech.name);
    }

    return grouped;
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _goBackToCategories() {
    setState(() {
      _selectedCategory = null;
    });
  }

  void _selectTechnology(BuildContext context, String tech) {
    AutoRouter.of(context).maybePop(tech);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectTechnologiesStackCubit>(
      create: (BuildContext context) => ProjectTechnologiesStackCubit(
        fetchProjectTechnologiesStackUseCase:
            appLocator<FetchProjectTechnologiesStackUseCase>(),
      ),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppDimens.borderRadius12,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            AppDimens.padding16,
          ),
          child: BlocBuilder<ProjectTechnologiesStackCubit,
              ProjectTechnologiesStackState>(
            builder:
                (BuildContext context, ProjectTechnologiesStackState state) {
              final List<ProjectTechnologyStackModel>? technologies =
                  state.technologyStack;

              if (technologies == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final Map<String, List<String>> groupedTechnologies =
                  _groupTechnologiesByCategory(technologies);

              return TechnologyStackList(
                groupedTechnologies: groupedTechnologies,
                selectedCategory: _selectedCategory,
                selectCategory: _selectCategory,
                selectTechnology: _selectTechnology,
                goBackToCategories: _goBackToCategories,
              );
            },
          ),
        ),
      ),
    );
  }
}
