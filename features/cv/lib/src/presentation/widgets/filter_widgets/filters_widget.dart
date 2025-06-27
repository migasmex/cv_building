import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../../../../cv.gm.dart';
import '../../blocs/cubit/cv_folder_cubit.dart';
import '../../utils/filters.dart';
import 'filter_chips.dart';
import 'filter_input_widget.dart';

class FiltersWidget extends StatefulWidget {
  final String folderName;
  final Filters filters;

  const FiltersWidget({
    super.key,
    required this.folderName,
    required this.filters,
  });

  @override
  State<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  late final TextEditingController _experienceController;
  late final TextEditingController _queryController;

  @override
  void initState() {
    super.initState();

    _experienceController = TextEditingController(
      text: widget.filters.experienceInYears?.toString() ?? '',
    );
    _queryController = TextEditingController();
  }

  void _onApplyFiltersPressed(BuildContext context) {
    widget.filters.experienceInYears =
        double.tryParse(_experienceController.text);

    if (widget.filters.isAnyFilterActive()) {
      context.read<CvFolderCubit>().applyFilters(
            query: _queryController.text,
            domains: widget.filters.domains ?? <String>[],
            experienceInYears: widget.filters.experienceInYears,
            folderName: widget.folderName,
          );

      AutoRouter.of(context).maybePop();

      final String? domains = widget.filters.domains?.join(',');

      final CvRoute cvRoute = CvRoute(
        folderName: widget.folderName,
        domains: domains,
        experienceInYears: widget.filters.experienceInYears ?? 0,
      );

      AutoRouter.of(context).replace(cvRoute);
    } else {
      _experienceController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.locale.wrongInput),
        ),
      );
    }
  }

  void _onResetAllPressed(BuildContext context) {
    widget.filters.clearFilters();

    _experienceController.clear();
    _queryController.clear();

    context.read<CvFolderCubit>().applyFilters(
          folderName: widget.folderName,
          query: '',
          domains: <String>[],
          experienceInYears: 0,
        );

    AutoRouter.of(context).maybePop();

    AutoRouter.of(context).replace(
      CvRoute(
        folderName: widget.folderName,
      ),
    );
  }

  void _clearFilter(FilterType filterType) {
    setState(() {
      switch (filterType) {
        case (FilterType.experience):
          widget.filters.experienceInYears = null;
          _experienceController.clear();
        case FilterType.domains:
          widget.filters.domains = null;
      }

      context.read<CvFolderCubit>().applyFilters(
            folderName: widget.folderName,
            query: _queryController.text,
            domains: widget.filters.domains ?? <String>[],
            experienceInYears: widget.filters.experienceInYears ?? 0,
          );

      final String? domains = widget.filters.domains?.join(',');

      final CvRoute cvRoute = CvRoute(
        folderName: widget.folderName,
        domains: domains,
        experienceInYears: widget.filters.experienceInYears ?? 0,
      );

      AutoRouter.of(context).replace(cvRoute);
    });
  }

  void _searchCv(BuildContext context, String? query) {
    context.read<CvFolderCubit>().applyFilters(
          query: query ?? '',
          domains: widget.filters.domains ?? <String>[],
          experienceInYears: widget.filters.experienceInYears ?? 0,
          folderName: widget.folderName,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FilterInputWidget(
          folderName: widget.folderName,
          queryController: _queryController,
          experienceController: _experienceController,
          searchCv: (String? query) => _searchCv(context, query),
          onApplyFilters: () => _onApplyFiltersPressed(context),
          onResetAll: () => _onResetAllPressed(context),
          filters: widget.filters,
        ),
        FilterChips(
          filters: widget.filters,
          clearFilter: _clearFilter,
        ),
      ],
    );
  }
}
