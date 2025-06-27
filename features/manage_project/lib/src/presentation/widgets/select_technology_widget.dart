import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'technology_checkbox_tile.dart';

class TechnologySelector extends StatelessWidget {
  final String selectedCategory;
  final List<String> technologies;
  final String searchQuery;
  final void Function(String) onSearchChanged;
  final Map<String, bool> selectedTechnologies;
  final void Function(String, bool) onTechnologySelected;
  final void Function() onBackToCategories;

  const TechnologySelector({
    required this.selectedCategory,
    required this.technologies,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.selectedTechnologies,
    required this.onTechnologySelected,
    required this.onBackToCategories,
  });

  void _handleConfirmPressed(BuildContext context) {
    final String selectedTechnologiesString = selectedTechnologies.entries
        .where((MapEntry<String, bool> entry) => entry.value)
        .map((MapEntry<String, bool> entry) => entry.key)
        .join(', ');

    AutoRouter.of(context).maybePop(selectedTechnologiesString);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            TextButton(
              onPressed: onBackToCategories,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_back,
                    color: AppColors.of(context).black,
                    size: 16,
                  ),
                  Text(
                    context.locale.backToCategories,
                    style: AppFonts.appTextStyle.copyWith(
                      color: AppColors.of(context).black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: AppDimens.padding16,
        ),
        Text(
          context.locale.selectTechnology,
          style: AppFonts.appBoldTextStyle.copyWith(
            color: AppColors.of(context).black,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: AppDimens.padding16,
        ),
        TextField(
          decoration: InputDecoration(
            labelStyle: AppFonts.appTextStyle,
            hintStyle: AppFonts.appTextStyle,
            hintText: context.locale.searchTechnology,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimens.borderRadius6,
              ),
            ),
            prefixIcon: const Icon(
              Icons.search,
            ),
          ),
          onChanged: onSearchChanged,
        ),
        const SizedBox(
          height: AppDimens.padding16,
        ),
        Column(
          children: technologies
              .where((String tech) => tech.toLowerCase().contains(searchQuery))
              .map(
            (String technologyName) {
              return TechnologyCheckboxTile(
                technologyName: technologyName,
                isSelected: selectedTechnologies[technologyName] ?? false,
                onChanged: (bool isChecked) {
                  onTechnologySelected(
                    technologyName,
                    isChecked,
                  );
                },
              );
            },
          ).toList(),
        ),
        AppButton(
          buttonText: context.locale.confirm,
          buttonWidth: AppDimens.constraint500,
          buttonHeight: AppDimens.constraint50,
          onPressed: () => _handleConfirmPressed(context),
        ),
      ],
    );
  }
}
