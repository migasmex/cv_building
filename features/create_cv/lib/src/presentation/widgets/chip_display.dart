import 'package:flutter/material.dart';

class ChipDisplay extends StatelessWidget {
  final List<String> values;
  final bool isSingleInputMode;
  final Function(String) onDeleted;

  const ChipDisplay({
    super.key,
    required this.values,
    required this.isSingleInputMode,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    if (isSingleInputMode) {
      if (values.isNotEmpty) {
        return Chip(
          label: Text(
            values.first,
          ),
          onDeleted: () => onDeleted(values.first),
        );
      } else {
        return Container();
      }
    } else {
      return Wrap(
        spacing: 8.0,
        children: values
            .map(
              (String value) => Chip(
                label: Text(value),
                onDeleted: () => onDeleted(value),
              ),
            )
            .toList(),
      );
    }
  }
}
