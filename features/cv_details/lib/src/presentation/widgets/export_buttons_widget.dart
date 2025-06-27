import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../blocs/cv_details_cubit/cv_details_cubit.dart';

class ExportButtonsWidget extends StatelessWidget {
  final CvModel cv;
  final List<ProjectModel> projects;

  const ExportButtonsWidget({
    required this.cv,
    required this.projects,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        AppDimens.padding12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CustomButton(
            onPressed: () => context.read<CvDetailsCubit>().exportCvToDocx(
                  cv,
                  projects,
                ),
            buttonText: context.locale.exportToDOCX,
            horizontalPadding: AppDimens.padding60,
            verticalPadding: AppDimens.padding20,
            borderRadius: AppDimens.borderRadius6,
            textStyle: AppFonts.cvCardText,
          ),
          CustomButton(
            onPressed: () => context.read<CvDetailsCubit>().exportCvToPdf(
                  cv,
                  projects,
                ),
            buttonText: context.locale.exportToPDF,
            horizontalPadding: AppDimens.padding60,
            verticalPadding: AppDimens.padding20,
            borderRadius: AppDimens.borderRadius6,
            textStyle: AppFonts.cvCardText,
          ),
        ],
      ),
    );
  }
}
