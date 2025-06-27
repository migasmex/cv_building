import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'grade.dart';

String localizedGrade(BuildContext context, Grade grade) {
  switch (grade) {
    case Grade.Junior:
      return context.locale.junior;
    case Grade.Middle:
      return context.locale.middle;
    case Grade.Senior:
      return context.locale.senior;
    case Grade.Lead:
      return context.locale.lead;
  }
}