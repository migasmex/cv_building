import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class SectionTitleWidget extends StatelessWidget {
  const SectionTitleWidget({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppFonts.appBoldTextStyle.copyWith(
        color: AppColors.of(context).black,
      ),
    );
  }
}
