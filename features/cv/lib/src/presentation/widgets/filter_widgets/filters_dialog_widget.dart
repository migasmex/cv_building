import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

class FiltersDialogWidget extends StatefulWidget {
  final TextEditingController experienceController;
  final VoidCallback onApplyFilters;
  final VoidCallback onResetAll;
  final Function(List<String>) onDomainsChanged;
  final List<String> initialDomains;

  const FiltersDialogWidget({
    super.key,
    required this.experienceController,
    required this.onApplyFilters,
    required this.onResetAll,
    required this.onDomainsChanged,
    this.initialDomains = const <String>[],
  });

  @override
  State<FiltersDialogWidget> createState() => _FiltersDialogWidgetState();
}

class _FiltersDialogWidgetState extends State<FiltersDialogWidget> {
  List<String> selectedDomains = <String>[];

  @override
  void initState() {
    super.initState();
    selectedDomains = widget.initialDomains;
  }

  void _updateDomainValues(List<String> updatedList) {
    setState(() {
      selectedDomains = updatedList;
    });
    widget.onDomainsChanged(updatedList);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.locale.filters,
        style: TextStyle(
          color: AppColors.of(context).black,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppTextFieldWidget(
            labelText: context.locale.experienceInYears,
            controller: widget.experienceController,
          ),
          const SizedBox(
            height: AppDimens.padding16,
          ),
          HintTextField(
            labelText: context.locale.enterDomains,
            suggestions: const <String>[
              'Entertainment application',
              'E-commerce',
              'Healthcare',
              'Finance',
              'Meditation',
              'Hiring',
              'Transport',
              'Inspection',
              'Dance',
              'Tourism',
            ],
            chosenSuggestions: selectedDomains,
            onChipListChanged: _updateDomainValues,
          ),
          const SizedBox(
            height: AppDimens.padding20,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            AutoRouter.of(context).maybePop();
          },
          child: Text(
            context.locale.back,
            style: TextStyle(
              color: AppColors.of(context).black,
            ),
          ),
        ),
        TextButton(
          onPressed: widget.onApplyFilters,
          child: Text(
            context.locale.apply,
            style: TextStyle(
              color: AppColors.of(context).black,
            ),
          ),
        ),
        TextButton(
          onPressed: widget.onResetAll,
          child: Text(
            context.locale.resetAll,
            style: TextStyle(
              color: AppColors.of(context).black,
            ),
          ),
        ),
      ],
    );
  }
}

