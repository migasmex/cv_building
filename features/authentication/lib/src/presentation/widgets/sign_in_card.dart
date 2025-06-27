import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../blocs/sign_in_bloc/sign_in_bloc.dart';

class SignInCard extends StatelessWidget {
  const SignInCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: AppDimens.constraint500,
        padding: const EdgeInsets.symmetric(
          vertical: AppDimens.padding30,
          horizontal: AppDimens.padding12,
        ),
        decoration: BoxDecoration(
          color: AppColors.of(context).black,
          borderRadius: BorderRadius.circular(
            AppDimens.borderRadius12,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              context.locale.signIn,
              style: TextStyle(
                color: AppColors.of(context).white,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: AppDimens.padding100,
            ),
            Text(
              context.locale.weAreGladToSeeYou,
              style: TextStyle(
                color: AppColors.of(context).white,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppDimens.padding50,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<SignInBloc>().add(
                        SignInRequestedEvent(),
                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.of(context).white,
                  foregroundColor: AppColors.of(context).black,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.padding20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimens.borderRadius12,
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.g_mobiledata,
                  size: AppDimens.constraint50,
                ),
                label: Text(
                  context.locale.signInWithGoogle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
