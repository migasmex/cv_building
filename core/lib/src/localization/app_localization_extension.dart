import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

extension AppLocalizationExtension on BuildContext {
  AppLocalization get locale {
    return AppLocalization.of(this);
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();
}
