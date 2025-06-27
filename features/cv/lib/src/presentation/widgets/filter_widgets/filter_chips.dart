import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../utils/filters.dart';
import 'cv_filter_chip.dart';

class FilterChips extends StatelessWidget {
  final Filters filters;
  final void Function(FilterType) clearFilter;

  const FilterChips({
    super.key,
    required this.filters,
    required this.clearFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppDimens.padding10,
      children: <Widget>[
        if (filters.experienceInYears != null && filters.experienceInYears != 0)
          CvFilterChip(
            filterText:
                context.locale.experienceYears(filters.experienceInYears!),
            onDeleted: () => clearFilter(FilterType.experience),
          ),
        if (filters.domains != null && filters.domains!.isNotEmpty)
          CvFilterChip(
            filterText: context.locale.domainsList(
              filters.domains!.join(', '),
            ),
            onDeleted: () => clearFilter(FilterType.domains),
          ),
      ],
    );
  }
}
