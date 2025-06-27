import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../../core_ui.dart';

class CvCard extends StatelessWidget {
  final CvModel cv;
  final void Function(CvModel)? _onDeleteCvPressed;
  final void Function(CvModel)? _onCvPressed;
  final String cardButtonTitle;

  const CvCard({
    super.key,
    required this.cv,
    required this.cardButtonTitle,
    void Function(CvModel)? deleteCv,
    void Function(CvModel)? onCvPressed,
  })  : _onDeleteCvPressed = deleteCv,
        _onCvPressed = onCvPressed;

  bool get _canDeleteCvCard => _onDeleteCvPressed != null;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);
    return SizedBox(
      width: AppDimens.constraint300,
      child: Card(
        color: colors.whiteCard,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.borderRadius12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(AppDimens.padding12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          context.locale.flutterEngineer,
                          style: AppFonts.cvCardText.copyWith(
                            color: colors.green,
                          ),
                        ),
                      ),
                      if (_canDeleteCvCard)
                        IconButton(
                          onPressed: () => _onDeleteCvPressed?.call(cv),
                          icon: const Icon(
                            Icons.delete,
                          ),
                        ),
                    ],
                  ),
                  Text(
                    cv.title,
                    style: AppFonts.cvCardText,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimens.padding12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    context.locale.experience,
                    style: AppFonts.cvCardText.copyWith(
                      color: colors.green,
                    ),
                  ),
                  Text(
                    context.locale.cvExperienceYears(
                          cv.experience,
                        ),
                    style: AppFonts.cvCardText,
                  ),
                ],
              ),
            ),
            Divider(
              color: colors.gray,
              thickness: 0.3,
            ),
            InkWell(
              onTap: () {
                _onCvPressed?.call(cv);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimens.padding6,
                  horizontal: AppDimens.padding12,
                ),
                child: Text(
                  cardButtonTitle,
                  style: AppFonts.cvCardText.copyWith(
                    color: colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
