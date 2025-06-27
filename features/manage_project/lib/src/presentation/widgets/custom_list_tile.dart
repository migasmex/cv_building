import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final TextStyle? textStyle;
  final Widget? trailing;

  const CustomListTile({
    required this.title,
    required this.onTap,
    this.textStyle,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: textStyle ??
            AppFonts.appTextStyle.copyWith(
              color: AppColors.of(context).black,
            ),
      ),
      onTap: onTap,
      trailing: trailing,
    );
  }
}
