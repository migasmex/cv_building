part of 'hint_text_field.dart';

class _HintListWidget extends StatelessWidget {
  const _HintListWidget({
    required this.options,
    required this.onSelected,
  });

  final AutocompleteOnSelected<String> onSelected;
  final Iterable<String> options;

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