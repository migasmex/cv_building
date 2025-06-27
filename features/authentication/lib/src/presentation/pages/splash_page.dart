import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:home/home.gm.dart';
import 'package:navigation/navigation.dart';

import '../../../authentication.gm.dart';
import '../blocs/check_auth_bloc/check_auth_bloc.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (BuildContext context) => SplashBloc(
        isUserAuthorizedUseCase: appLocator<IsUserAuthorizedUseCase>(),
      ),
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (BuildContext context, SplashState state) {
          switch (state.status) {
            case SplashStatus.loading:
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.of(context).black,
                ),
              );

            case SplashStatus.authenticated:
              AutoRouter.of(context).replace(
                HomeRoute(),
              );
              break;

            case SplashStatus.unauthenticated:
              AutoRouter.of(context).replace(
                const SignInRoute(),
              );
              break;
          }

          return CircularProgressIndicator(
            color: AppColors.of(context).black,
          );
        },
      ),
    );
  }
}
