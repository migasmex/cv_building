import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final List<String> categories;
  final void Function(String) onCategorySelected;

  const CategorySelector({
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          context.locale.selectTechnology,
          style: AppFonts.appBoldTextStyle.copyWith(
            color: AppColors.of(context).black,
          ),
        ),
        const SizedBox(
          height: AppDimens.padding16,
        ),
        Column(
          children: categories.map(
            (String category) {
              return ListTile(
                title: Text(
                  category,
                  style: AppFonts.appTextStyle,
                ),
                onTap: () {
                  onCategorySelected(category);
                },
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
