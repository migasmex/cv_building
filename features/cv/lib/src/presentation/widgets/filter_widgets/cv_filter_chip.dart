import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class CvFilterChip extends StatelessWidget {
  final String filterText;
  final VoidCallback onDeleted;

  const CvFilterChip({
    super.key,
    required this.filterText,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        filterText,
        style: TextStyle(
          color: AppColors.of(context).white,
        ),
      ),
      backgroundColor: AppColors.of(context).black,
      deleteIcon: Icon(
        Icons.close,
        color: AppColors.of(context).white,
      ),
      onDeleted: onDeleted,
    );
  }
}