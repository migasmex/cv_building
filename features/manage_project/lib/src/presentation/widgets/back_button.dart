import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class BackToCategoriesButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BackToCategoriesButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
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
    );
  }
}
