import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final String hintText;
  final ValueChanged<String> onChanged;

  const DropdownWidget({
    required this.items,
    required this.selectedValue,
    required this.hintText,
    required this.onChanged,
    super.key,
  });

  void _handleValueChange(String? value) {
    if (value != null) {
      onChanged(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimens.constraint500,
      height: AppDimens.constraint40,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedValue,
        hint: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.padding12,
          ),
          child: Text(
            hintText,
            style: AppFonts.appTextStyle.copyWith(
              color: AppColors.of(context).black,
              fontSize: 16,
            ),
          ),
        ),
        underline: const SizedBox(),
        onChanged: _handleValueChange,
        items: items.map(
          (String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Padding(
                padding: const EdgeInsets.all(
                  AppDimens.padding8,
                ),
                child: Text(
                  item,
                  style: AppFonts.appTextStyle.copyWith(
                    color: AppColors.of(context).black,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
