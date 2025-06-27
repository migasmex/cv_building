import 'package:flutter/material.dart';
import '../../../core_ui.dart';

class AppTextFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final double? width;

  const AppTextFieldWidget({
    super.key,
    required this.labelText,
    required this.controller,
    this.focusNode,
    this.onSubmitted,
    this.suffixIcon,
    this.onChanged,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: TextField(
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        cursorColor: AppColors.of(context).black,
        focusNode: focusNode,
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          isDense: true,
          suffixIcon: suffixIcon,
          labelText: labelText,
          labelStyle: TextStyle(
            color: AppColors.of(context).black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.of(context).black,
            ),
            borderRadius: BorderRadius.zero,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.of(context).black,
            ),
            borderRadius: BorderRadius.zero,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 12.0,
          ),
        ),
        style: TextStyle(
          color: AppColors.of(context).black,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
