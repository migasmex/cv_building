import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

class AddAchievementDialogWidget extends StatefulWidget {
  final String? keyText;
  final String? valueText;

  const AddAchievementDialogWidget({
    this.keyText,
    this.valueText,
    Key? key,
  }) : super(key: key);

  @override
  State<AddAchievementDialogWidget> createState() => _AchievementDialogState();
}

class _AchievementDialogState extends State<AddAchievementDialogWidget> {
  late final TextEditingController _keyController;
  late final TextEditingController _valueController;

  @override
  void initState() {
    super.initState();
    _keyController = TextEditingController(
      text: widget.keyText,
    );
    _valueController = TextEditingController(
      text: widget.valueText,
    );
  }

  void _closeDialog() {
    AutoRouter.of(context).maybePop();
  }

  void _submitKeyValue() {
    final String key = _keyController.text.trim();
    final String value = _valueController.text.trim();

    if (key.isNotEmpty && value.isNotEmpty) {
      AutoRouter.of(context).maybePop(
        MapEntry<String, String>(key, value),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.locale.addAchievement,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppTextFieldWidget(
            labelText: context.locale.achievements,
            controller: _keyController,
          ),
          const SizedBox(
            height: AppDimens.padding10,
          ),
          AppTextFieldWidget(
            labelText: context.locale.description,
            controller: _valueController,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: _closeDialog,
          child: Text(
            context.locale.back,
            style: AppFonts.cvCardText,
          ),
        ),
        TextButton(
          onPressed: _submitKeyValue,
          child: Text(
            context.locale.apply,
            style: AppFonts.cvCardText,
          ),
        ),
      ],
    );
  }
}
