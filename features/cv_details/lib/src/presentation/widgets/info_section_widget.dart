import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class InfoSectionWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const InfoSectionWidget({
    required this.icon,
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        vertical: AppDimens.padding10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimens.borderRadius12,
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.of(context).black,
          size: 32,
        ),
        title: Text(
          title,
          textAlign: TextAlign.start,
          style: AppFonts.appBoldTextStyle.copyWith(
            color: AppColors.of(context).black,
          ),
        ),
        subtitle: Text(
          content,
          textAlign: TextAlign.start,
          style: AppFonts.appTextStyle.copyWith(
            color: AppColors.of(context).gray,
          ),
        ),
      ),
    );
  }
}