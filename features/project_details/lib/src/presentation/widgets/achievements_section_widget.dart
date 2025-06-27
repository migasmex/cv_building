import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'section_title_widget.dart';

class AchievementsSectionWidget extends StatelessWidget {
  final List<String> achievements;

  const AchievementsSectionWidget({
    required this.achievements,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SectionTitleWidget(
          title: context.locale.responsibilitiesAchievements,
        ),
        const SizedBox(
          height: AppDimens.padding10,
        ),
        for (final String achievement in achievements)
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimens.padding5,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: colors.green,
                  size: AppDimens.constraint25,
                ),
                const SizedBox(
                  width: AppDimens.padding10,
                ),
                Expanded(
                  child: Text(
                    achievement,
                    style: AppFonts.appTextStyle.copyWith(
                      color: colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
