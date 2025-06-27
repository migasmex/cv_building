import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../utils/filters.dart';
import 'filters_dialog_widget.dart';

class FilterInputWidget extends StatefulWidget {
  final TextEditingController queryController;
  final TextEditingController experienceController;
  final VoidCallback onApplyFilters;
  final VoidCallback onResetAll;
  final void Function(String?) searchCv;
  final String folderName;
  final Filters filters;

  const FilterInputWidget({
    super.key,
    required this.queryController,
    required this.experienceController,
    required this.onApplyFilters,
    required this.onResetAll,
    required this.folderName,
    required this.searchCv,
    required this.filters,
  });

  @override
  State<FilterInputWidget> createState() => _FilterInputWidgetState();
}

class _FilterInputWidgetState extends State<FilterInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: AppTextFieldWidget(
            labelText: context.locale.searchByTitle,
            controller: widget.queryController,
            onChanged: widget.searchCv,
          ),
        ),
        const SizedBox(width: AppDimens.padding20),
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => FiltersDialogWidget(
                experienceController: widget.experienceController,
                onApplyFilters: widget.onApplyFilters,
                onResetAll: widget.onResetAll,
                onDomainsChanged: _selectDomains,
                initialDomains: widget.filters.domains ?? <String>[],
              ),
            );
          },
        ),
      ],
    );
  }

  void _selectDomains(List<String> selectedDomains) {
    setState(() {
      widget.filters.domains = selectedDomains;
    });
  }
}
