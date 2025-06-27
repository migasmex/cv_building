import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../utils/cv_generation_type.dart';

class AddCvDialogWidget extends StatelessWidget {
  const AddCvDialogWidget({super.key});

  void _createNewCv(BuildContext context) {
    AutoRouter.of(context).maybePop(CvGenerationType.newCv);
  }

  void _addBasicCv(BuildContext context)  {
    AutoRouter.of(context).maybePop(CvGenerationType.basicCv);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.locale.addCV,
        style: TextStyle(
          color: AppColors.of(context).black,
        ),
      ),
      content: Text(
        context.locale.chooseAnOptionToAddCV,
        style: TextStyle(
          color: AppColors.of(context).black,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            _createNewCv(context);
          },
          child: Text(
            context.locale.createNewCV,
            style: TextStyle(
              color: AppColors.of(context).black,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            _addBasicCv(context);
          },
          child: Text(
            context.locale.addFromExisting,
            style: TextStyle(
              color: AppColors.of(context).black,
            ),
          ),
        ),
      ],
    );
  }
}


