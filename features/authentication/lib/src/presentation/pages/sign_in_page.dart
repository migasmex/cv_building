import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:home/home.gm.dart';
import 'package:navigation/navigation.dart';
import '../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../widgets/sign_in_card.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).white,
      body: BlocProvider<SignInBloc>(
        create: (BuildContext context) => SignInBloc(
          signInUseCase: appLocator<SignInUseCase>(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.padding20),
          child: BlocConsumer<SignInBloc, SignInState>(
            listener: (BuildContext context, SignInState state) {
              if (state.status == SignInStatus.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      context.locale.successfulSignedIn,
                    ),
                  ),
                );
                AutoRouter.of(context).replace(
                  HomeRoute(),
                );
              } else if (state.status == SignInStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.error ?? context.locale.signInFailed,
                    ),
                  ),
                );
              }
            },
            builder: (BuildContext context, SignInState state) {
              return const SignInCard();
            },
          ),
        ),
      ),
    );
  }
}
