import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../cubit/project_techonologies_cubit/project_technologies_cubit.dart';
import 'select_category_widget.dart';
import 'select_technology_widget.dart';

class TechnologiesSelectorWidget extends StatefulWidget {
  @override
  _TechnologiesSelectorWidgetState createState() =>
      _TechnologiesSelectorWidgetState();
}

class _TechnologiesSelectorWidgetState
    extends State<TechnologiesSelectorWidget> {
  String? selectedCategory;
  String searchQuery = '';
  final Map<String, bool> selectedTechnologies = <String, bool>{};

  void _handleCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
      searchQuery = '';
      selectedTechnologies.clear();
    });
  }

  void _handleSearchChanged(String value) {
    setState(() {
      searchQuery = value.toLowerCase();
    });
  }

  void _handleTechnologySelected(String tech, bool isChecked) {
    setState(() {
      selectedTechnologies[tech] = isChecked;
    });
  }

  void _goBack() {
    setState(() {
      selectedCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectTechnologiesCubit>(
      create: (BuildContext context) => ProjectTechnologiesCubit(
        fetchProjectTechnologiesUseCase:
            appLocator<FetchProjectTechnologiesUseCase>(),
      ),
      child: BlocBuilder<ProjectTechnologiesCubit, ProjectTechnologiesState>(
        builder: (BuildContext context, ProjectTechnologiesState state) {
          if (state.technologies == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final Map<String, List<ProjectTechnologyModel>> technologyStack =
              <String, List<ProjectTechnologyModel>>{};
          for (final ProjectTechnologyModel technology in state.technologies!) {
            technologyStack
                .putIfAbsent(
                  technology.category,
                  () => <ProjectTechnologyModel>[],
                )
                .add(technology);
          }

          return Dialog(
            backgroundColor: AppColors.of(context).white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppDimens.borderRadius12,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                AppDimens.padding16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (selectedCategory == null)
                      CategorySelector(
                        categories: technologyStack.keys.toList(),
                        onCategorySelected: _handleCategorySelected,
                      ),
                    if (selectedCategory != null)
                      TechnologySelector(
                        selectedCategory: selectedCategory!,
                        technologies: technologyStack[selectedCategory!]!
                            .map(
                              (ProjectTechnologyModel technology) =>
                                  technology.name,
                            )
                            .toList(),
                        searchQuery: searchQuery,
                        onSearchChanged: _handleSearchChanged,
                        selectedTechnologies: selectedTechnologies,
                        onTechnologySelected: _handleTechnologySelected,
                        onBackToCategories:
                            _goBack,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
