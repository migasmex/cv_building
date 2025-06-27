import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class FolderCardWidget extends StatelessWidget {
  final String title;

  const FolderCardWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.of(context).gray,
        ),
        borderRadius: BorderRadius.circular(
          AppDimens.borderRadius12,
        ),
        color: AppColors.of(context).white,
      ),
      padding: const EdgeInsets.all(
        AppDimens.padding6,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.folder,
            size: AppDimens.constraint25,
            color: AppColors.of(context).gray,
          ),
          const SizedBox(
            width: AppDimens.padding20,
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.of(context).black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
