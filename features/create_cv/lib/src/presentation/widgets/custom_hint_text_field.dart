import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'chip_display.dart';
import 'suggestions_list_tile.dart';

class CustomHintTextField extends StatefulWidget {
  final Function(List<String>) onValuesChanged;
  final List<String> suggestions;
  final String labelText;
  final bool isSingleInputMode;

  const CustomHintTextField({
    super.key,
    required this.onValuesChanged,
    required this.suggestions,
    required this.labelText,
    this.isSingleInputMode = false,
  });

  @override
  State<CustomHintTextField> createState() => _CustomHintTextFieldState();
}

class _CustomHintTextFieldState extends State<CustomHintTextField> {
  List<String> values = <String>[];

  void _addValues(String newValue, TextEditingController controller) {
    final String trimmedValue = newValue.trim();
    if (trimmedValue.isNotEmpty) {
      final String language = trimmedValue.split(' – ')[0];
      if (values.contains(language)) {
        return;
      }
      setState(() {
        if (widget.isSingleInputMode) {
          values = <String>[trimmedValue];
          widget.onValuesChanged(values);
        } else {
          if (!_isDuplicate(trimmedValue)) {
            values.add(trimmedValue);
            widget.onValuesChanged(values);
          }
        }
      });
    }
    controller.clear();
  }

  bool _isDuplicate(String newValue) {
    return values.any(
      (String existingValue) => existingValue
          .toLowerCase()
          .startsWith(newValue.substring(0, 4).toLowerCase()),
    );
  }

  void _removeValue(String valueToRemove) {
    setState(() {
      values.remove(valueToRemove);
      widget.onValuesChanged(values);
    });
  }

  List<String> _filteredSuggestions() {
    return widget.suggestions
        .where((String option) => !values.contains(option))
        .toList();
  }

  Widget _buildFieldView(
    BuildContext context,
    TextEditingController textEditingController,
    FocusNode focusNode,
    VoidCallback onFieldSubmitted,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppTextFieldWidget(
          width: AppDimens.constraint300,
          labelText: widget.labelText,
          controller: textEditingController,
          focusNode: focusNode,
          onSubmitted: (String value) =>
              _addValues(value, textEditingController),
          suffixIcon: IconButton(
            onPressed: () =>
                _addValues(textEditingController.text, textEditingController),
            icon: const Icon(
              Icons.add,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionsView(
    BuildContext context,
    AutocompleteOnSelected<String> onSelected,
    Iterable<String> options,
  ) {
    return SuggestionsListTile(
      options: options,
      onSelected: onSelected,
    );
  }

  void _onSelectedAdd(String value) {
    _addValues(value, TextEditingController());
  }

  List<String> _filteredSuggestionsOptions(TextEditingValue textEditingValue) {
    final List<String> filteredSuggestions = _filteredSuggestions();
    return filteredSuggestions.where(
      (String option) {
        return option.toLowerCase().contains(
              textEditingValue.text.toLowerCase(),
            );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimens.constraint300,
      child: Column(
        children: <Widget>[
          Autocomplete<String>(
            fieldViewBuilder: _buildFieldView,
            optionsBuilder: _filteredSuggestionsOptions,
            onSelected: _onSelectedAdd,
            optionsViewBuilder: _buildOptionsView,
          ),
          ChipDisplay(
            values: values,
            isSingleInputMode: widget.isSingleInputMode,
            onDeleted: _removeValue,
          ),
        ],
      ),
    );
  }
}
