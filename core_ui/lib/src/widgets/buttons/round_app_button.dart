import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class RoundAppButton extends StatelessWidget {
  const RoundAppButton({
    super.key,
    required this.title,
    required this.colors,
    required this.onPressed,
  });

  final AppColors colors;
  final void Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.constraint100,
      width: AppDimens.constraint100,
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: colors.black,
        shape: const CircleBorder(),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
