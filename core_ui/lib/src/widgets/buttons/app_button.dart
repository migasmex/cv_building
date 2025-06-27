import 'package:flutter/material.dart';

import '../../../core_ui.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.buttonText,
    required this.buttonWidth,
    required this.buttonHeight,
    this.onPressed,
  });

  final String buttonText;
  final double buttonWidth;
  final double buttonHeight;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color?>(
          AppColors.of(context).black,
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(
            vertical: AppDimens.padding20,
            horizontal: AppDimens.padding100,
          ),
        ),
        minimumSize: WidgetStatePropertyAll<Size?>(
          Size(
            buttonWidth,
            buttonHeight,
          ),
        ),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          color: AppColors.of(context).white,
        ),
      ),
    );
  }
}
