import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'back_button.dart';
import 'custom_list_tile.dart';

class TechnologyStackList extends StatelessWidget {
  final Map<String, List<String>> groupedTechnologies;
  final String? selectedCategory;
  final Function(String) selectCategory;
  final Function(BuildContext, String) selectTechnology;
  final VoidCallback goBackToCategories;

  const TechnologyStackList({
    required this.groupedTechnologies,
    required this.selectedCategory,
    required this.selectCategory,
    required this.selectTechnology,
    required this.goBackToCategories,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: () {
        if (selectedCategory == null) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                context.locale.selectStack,
                style: AppFonts.appBoldTextStyle.copyWith(
                  fontSize: 20,
                  color: AppColors.of(context).black,
                ),
              ),
              const SizedBox(
                height: AppDimens.padding16,
              ),
              Column(
                children: groupedTechnologies.keys.map(
                  (String category) {
                    return CustomListTile(
                      title: category,
                      onTap: () {
                        selectCategory(category);
                      },
                    );
                  },
                ).toList(),
              ),
            ],
          );
        } else {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  BackToCategoriesButton(
                    onPressed: goBackToCategories,
                  ),
                ],
              ),
              const SizedBox(
                height: AppDimens.padding16,
              ),
              Text(
                context.locale.selectTechnologySet,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.of(context).black,
                ),
              ),
              const SizedBox(
                height: AppDimens.padding16,
              ),
              Column(
                children: groupedTechnologies[selectedCategory]!.map(
                  (String tech) {
                    return CustomListTile(
                      title: tech,
                      onTap: () => selectTechnology(context, tech),
                    );
                  },
                ).toList(),
              ),
            ],
          );
        }
      }(),
    );
  }
}
