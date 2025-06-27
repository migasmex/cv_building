import 'package:flutter/material.dart';

abstract class AppColors {
  factory AppColors.of(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    return brightness == Brightness.light
        ? const LightColors()
        : const DarkColors();
  }

  Color get primaryBg;

  Color get white;

  Color get black;

  Color get gray;

  Color get red;

  Color get green;

  Color get whiteCard;

  Color get blue;
}

class DarkColors extends LightColors {
  const DarkColors();
}

class LightColors implements AppColors {
  const LightColors();

  @override
  Color get primaryBg => const Color(0xFFeceff1);

  @override
  Color get white => const Color(0xFFFFFFFF);

  @override
  Color get black => const Color(0xFF000000);

  @override
  Color get gray => const Color(0xFF918C8C);

  @override
  Color get red => const Color(0xFFB10824);

  @override
  Color get green => const Color(0xFF4C5A0D);

  @override
  Color get whiteCard => const Color(0xFFfcfbf7);

  @override
  Color get blue => const Color(0xff2c7afd);
}
