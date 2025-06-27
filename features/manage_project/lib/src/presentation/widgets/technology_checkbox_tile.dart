import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class TechnologyCheckboxTile extends StatelessWidget {
  final String technologyName;
  final bool isSelected;
  final void Function(bool) onChanged;

  const TechnologyCheckboxTile({
    required this.technologyName,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        technologyName,
        style: TextStyle(
          color: AppColors.of(context).black,
        ),
      ),
      activeColor: AppColors.of(context).black,
      value: isSelected,
      onChanged: (bool? isChecked) {
        if (isChecked != null) {
          onChanged(isChecked);
        }
      },
    );
  }
}