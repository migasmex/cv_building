import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class BasicCvBannerWidget extends StatelessWidget {
  const BasicCvBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppDimens.padding16),
      padding: const EdgeInsets.all(AppDimens.padding16),
      decoration: BoxDecoration(
        color: AppColors.of(context).black,
        borderRadius: BorderRadius.circular(AppDimens.borderRadius6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.info_outline,
            color: AppColors.of(context).white,
          ),
          const SizedBox(width: AppDimens.padding10),
          Text(
            context.locale.thisIsBasicCV,
            style: TextStyle(
              color: AppColors.of(context).white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}