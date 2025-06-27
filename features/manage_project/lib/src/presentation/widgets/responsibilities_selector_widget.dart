import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../cubit/project_responsibilities_cubit/project_responsibilities_cubit.dart';
import 'checkbox_list_widget.dart';
import 'dropdown_widget.dart';

class ResponsibilitiesSelectorWidget extends StatefulWidget {
  final Function(List<String>) onSelectionChanged;

  const ResponsibilitiesSelectorWidget({
    required this.onSelectionChanged,
    super.key,
  });

  @override
  _ResponsibilitiesSelectorWidgetState createState() =>
      _ResponsibilitiesSelectorWidgetState();
}

class _ResponsibilitiesSelectorWidgetState
    extends State<ResponsibilitiesSelectorWidget> {
  String? selectedLanguage;
  String? selectedCategory;
  Map<String, Set<String>> selectedItems = <String, Set<String>>{};

  List<String> _getAllSelectedValues() {
    final List<String> allSelectedItems = <String>[];
    selectedItems.values.forEach(allSelectedItems.addAll);
    return allSelectedItems;
  }

  void _toggleSelection(String item) {
    final Set<String> selectedSet =
        selectedItems[selectedCategory!] ??= <String>{};

    setState(() {
      if (selectedSet.contains(item)) {
        selectedSet.remove(item);
      } else {
        selectedSet.add(item);
      }
    });

    widget.onSelectionChanged(_getAllSelectedValues());
  }

  void _updateLanguage(String newLanguage, BuildContext context) {
    setState(() {
      selectedLanguage = newLanguage;
      selectedCategory = null;
      selectedItems.clear();
    });

    context.read<ProjectResponsibilitiesCubit>().loadCategories(newLanguage);
  }

  void _updateCategory(String newCategory) {
    setState(() {
      selectedCategory = newCategory;
      if (!selectedItems.containsKey(newCategory)) {
        selectedItems[newCategory] = <String>{};
      }
    });

    widget.onSelectionChanged(_getAllSelectedValues());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectResponsibilitiesCubit>(
      create: (BuildContext context) => ProjectResponsibilitiesCubit(
        getLanguagesUseCase: appLocator<FetchLanguagesUseCase>(),
        getCategoriesUseCase: appLocator<FetchCategoriesUseCase>(),
      ),
      child: BlocBuilder<ProjectResponsibilitiesCubit,
          ProjectResponsibilitiesState>(
        builder: (BuildContext context, ProjectResponsibilitiesState state) {
          if (state.languages == null) {
            return const CircularProgressIndicator();
          }

          final List<String> languages = state.languages!
              .map((LanguageModel language) => language.language)
              .toList();

          final Map<String, List<String>> categories = <String, List<String>>{};

          if (state.categories != null) {
            for (final CategoryModel category in state.categories!) {
              categories[category.category] = category.responsibilities;
            }
          }

          final List<String> responsibilities = selectedCategory != null
              ? categories[selectedCategory] ?? <String>[]
              : <String>[];

          return Column(
            children: <Widget>[
              DropdownWidget(
                items: languages,
                selectedValue: selectedLanguage,
                hintText: context.locale.selectLanguage,
                onChanged: (String value) {
                  _updateLanguage(value, context);
                },
              ),
              const SizedBox(
                height: AppDimens.padding16,
              ),
              if (selectedLanguage != null)
                DropdownWidget(
                  items: categories.keys.toList(),
                  selectedValue: selectedCategory,
                  hintText: context.locale.selectCategory,
                  onChanged: _updateCategory,
                ),
              if (selectedCategory != null)
                CheckboxListWidget(
                  items: responsibilities,
                  selectedItems: selectedItems[selectedCategory] ?? <String>{},
                  onItemChanged: _toggleSelection,
                ),
            ],
          );
        },
      ),
    );
  }
}
