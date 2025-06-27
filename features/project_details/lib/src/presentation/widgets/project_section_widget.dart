import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'section_title_widget.dart';

class ProjectSectionWidget extends StatelessWidget {
  final String title;
  final String content;

  const ProjectSectionWidget({
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SectionTitleWidget(
          title: title,
        ),
        const SizedBox(
          height: AppDimens.padding10,
        ),
        Text(
          content,
          style: AppFonts.appTextStyle.copyWith(
            color: AppColors.of(context).black,
          ),
        ),
        const SizedBox(
          height: AppDimens.padding16,
        ),
      ],
    );
  }
}
