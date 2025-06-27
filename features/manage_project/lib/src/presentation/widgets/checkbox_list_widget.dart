import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class CheckboxListWidget extends StatelessWidget {
  final List<String> items;
  final Set<String> selectedItems;
  final ValueChanged<String> onItemChanged;

  const CheckboxListWidget({
    required this.items,
    required this.selectedItems,
    required this.onItemChanged,
    super.key,
  });

  void _handleCheckboxChange({
    required bool? value,
    required String item,
  }) {
    if (value != null) {
      onItemChanged(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map(
        (String item) {
          return CheckboxListTile(
            checkColor: AppColors.of(context).black,
            title: Text(
              item,
              style: AppFonts.appTextStyle,
            ),
            value: selectedItems.contains(
              item,
            ),
            onChanged: (bool? value) => _handleCheckboxChange(
              value: value,
              item: item,
            ),
          );
        },
      ).toList(),
    );
  }
}
