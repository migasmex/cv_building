import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class SuggestionsListTile extends StatelessWidget {
  final Iterable<String> options;
  final AutocompleteOnSelected<String> onSelected;

  const SuggestionsListTile({
    Key? key,
    required this.options,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: AppDimens.constraint150,
          maxWidth: AppDimens.constraint300,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.of(context).black,
          ),
        ),
        child: Material(
          elevation: 4.0,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final String option = options.elementAt(index);
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.of(context).white,
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.of(context).black,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    option,
                    style: TextStyle(
                      color: AppColors.of(context).black,
                    ),
                  ),
                  onTap: () => onSelected(option),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
