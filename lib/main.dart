import 'dart:ui';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:navigation/navigation.dart';

import 'error_handler/provider/app_error_handler_provider.dart';
import 'firebase_options.dart';
import 'utils/setup_di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  const SetupDI setupDI = SetupDI();
  await setupDI.setupDI(Flavor.dev);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = appLocator<AppRouter>();

    return Builder(
      builder: (BuildContext context) {
        return AppErrorHandlerProvider(
          child: MaterialApp.router(
            localizationsDelegates: const <LocalizationsDelegate<Object>>[
              AppLocalizationExtension.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales:
                AppLocalizationExtension.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter.config(),
            locale: AppLocalizationExtension.delegate.supportedLocales.first,
            theme: lightTheme,
          ),
        );
      },
    );
  }
}
