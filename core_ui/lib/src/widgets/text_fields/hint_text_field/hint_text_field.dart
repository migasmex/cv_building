import 'package:flutter/material.dart';
import '../../../../core_ui.dart';

part 'hint_list_widget.dart';

class HintTextField extends StatefulWidget {
  final Function(List<String>) onChipListChanged;
  final List<String>? suggestions;
  final String labelText;
  final List<String>? chosenSuggestions;

  const HintTextField({
    super.key,
    required this.onChipListChanged,
    required this.labelText,
    this.chosenSuggestions,
    this.suggestions,
  });

  @override
  State<HintTextField> createState() => _HintTextFieldState();
}

class _HintTextFieldState extends State<HintTextField> {
  void _addChip(String value) {
    if (value.isNotEmpty && !widget.chosenSuggestions!.contains(value)) {
      setState(() {
        widget.chosenSuggestions!.add(value);
        widget.onChipListChanged(widget.chosenSuggestions!);
      });
    }
  }

  double calculateWrapHeight(int itemCount) {
    const int chipsPerRow = 4;
    const double chipHeight = 48.0;
    const int maxRows = 5;

    final int rows = (itemCount / chipsPerRow).ceil();
    return (rows > maxRows ? maxRows : rows) * chipHeight;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimens.constraint500,
      child: Column(
        children: <Widget>[
          Autocomplete<String>(
            fieldViewBuilder: (
              BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted,
            ) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AppTextFieldWidget(
                    width: AppDimens.constraint500,
                    labelText: widget.labelText,
                    controller: textEditingController,
                    focusNode: focusNode,
                    onSubmitted: (String value) {
                      if (widget.suggestions == null) {
                        _addChip(value);
                        textEditingController.clear();
                        FocusScope.of(context).unfocus();
                      }
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        _addChip(textEditingController.text);
                        textEditingController.clear();
                        FocusScope.of(context).unfocus();
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                ],
              );
            },
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (widget.suggestions == null) {
                return const Iterable<String>.empty();
              }
              return widget.suggestions!.where((String option) {
                return option.toLowerCase().contains(
                      textEditingValue.text.toLowerCase(),
                    );
              });
            },
            onSelected: widget.suggestions != null ? _addChip : null,
            optionsViewBuilder: widget.suggestions != null
                ? (
                    BuildContext context,
                    AutocompleteOnSelected<String> onSelected,
                    Iterable<String> options,
                  ) {
                    return _HintListWidget(
                      options: options,
                      onSelected: onSelected,
                    );
                  }
                : null,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: calculateWrapHeight(widget.chosenSuggestions!.length),
            ),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: AppDimens.padding12,
                children: widget.chosenSuggestions!
                    .map(
                      (String tech) => Chip(
                        label: Text(tech),
                        onDeleted: () {
                          setState(() {
                            widget.chosenSuggestions!.remove(
                              tech,
                            );

                            widget.onChipListChanged(
                              widget.chosenSuggestions!,
                            );
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
