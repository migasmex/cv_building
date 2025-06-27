import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../blocs/cv_details_cubit/cv_details_cubit.dart';
import 'cv_details_content_widget.dart';

class CvDetailsBodyWidget extends StatelessWidget {
  final String? cvIdToChange;
  final String? projectIdToReplace;
  final String id;

  const CvDetailsBodyWidget({
    required this.id,
    required this.cvIdToChange,
    required this.projectIdToReplace,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CvDetailsCubit, CvDetailsState>(
      builder: (BuildContext context, CvDetailsState state) {
        switch (state.runtimeType) {
          case CvDetailsLoading:
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.of(context).black,
              ),
            );

          case CvDetailsLoaded:
            final CvDetailsLoaded loadedState = state as CvDetailsLoaded;
            return CvDetailsContentWidget(
              projectIdToReplace: projectIdToReplace,
              cvIdToChange: cvIdToChange,
              cv: loadedState.cv,
              projects: loadedState.projects,
            );

          case CvDetailsLoadingFailure:
            final CvDetailsLoadingFailure failureState =
            state as CvDetailsLoadingFailure;
            return Center(
              child: Text(
                failureState.message,
              ),
            );

          default:
            return Center(
              child: Text(
                context.locale.someErrorOccurred,
              ),
            );
        }
      },
    );
  }
}
