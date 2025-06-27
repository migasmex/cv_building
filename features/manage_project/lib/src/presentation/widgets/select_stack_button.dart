import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'technology_selector_widget.dart';

class SelectStackButton extends StatelessWidget {
  final Function(List<String>) onSelectionChanged;

  const SelectStackButton({
    required this.onSelectionChanged,
  });

  Future<void> _handleSelectStackButtonPressed(BuildContext context) async {
    final String? selectedTechnology = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => TechnologiesSelectorWidget(),
    );

    if (selectedTechnology != null) {
      onSelectionChanged(
        <String>[
          selectedTechnology,
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.padding30,
          vertical: AppDimens.padding15,
        ),
        shape: const RoundedRectangleBorder(
          side: BorderSide(),
        ),
      ),
      onPressed: () => _handleSelectStackButtonPressed(context),
      child: Text(
        context.locale.selectStack,
        style: AppFonts.appTextStyle.copyWith(
          fontSize: 16,
        ),
      ),
    );
  }
}
