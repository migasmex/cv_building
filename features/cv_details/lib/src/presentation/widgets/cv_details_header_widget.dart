import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'basic_cv_banner_widget.dart';
import 'info_section_widget.dart';

class CvDetailsHeaderWidget extends StatelessWidget {
  final CvModel cv;
  final List<ProjectModel> projects;

  const CvDetailsHeaderWidget({
    required this.cv,
    required this.projects,
    super.key,
  });

  String _formatAchievements(Map<String, String> achievements) {
    return achievements.entries
        .map((MapEntry<String, String> entry) => '${entry.key}: ${entry.value}')
        .join('\n');
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          cv.title,
          style: AppFonts.cvDetailsHeaderTextStyle.copyWith(
            color: AppColors.of(context).black,
          ),
        ),
        Text(
          cv.grade,
          style: AppFonts.cvDetailsHeaderTextStyle.copyWith(
            color: AppColors.of(context).black,
          ),
        ),
        SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: AppDimens.padding16),
                    InfoSectionWidget(
                      icon: Icons.school,
                      title: context.locale.education,
                      content: cv.education,
                    ),
                    InfoSectionWidget(
                      icon: Icons.language,
                      title: context.locale.achievements,
                      content: cv.language,
                    ),
                    InfoSectionWidget(
                      icon: Icons.domain,
                      title: context.locale.domains,
                      content: projects
                          .map((ProjectModel project) => project.title)
                          .join(', '),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: AppDimens.padding16,
              ),
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),
                    InfoSectionWidget(
                      icon: Icons.info,
                      title: cv.selfIntroTitle,
                      content: cv.selfIntro,
                    ),
                    const SizedBox(height: AppDimens.padding16),
                  ],
                ),
              ),
            ],
          ),
        ),
        InfoSectionWidget(
          icon: Icons.star,
          title: context.locale.achievements,
          content: _formatAchievements(cv.achievements),
        ),
        if (cv.isBasic) const BasicCvBannerWidget(),
        InfoSectionWidget(
          icon: Icons.date_range,
          title: context.locale.createdAt,
          content: _formatDate(cv.createdAt),
        ),
      ],
    );
  }
}
