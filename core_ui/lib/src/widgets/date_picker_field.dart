import 'package:flutter/material.dart';
import '../../core_ui.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField({
    Key? key,
    required this.dateController,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.labelText,
    required this.onDateSelected,
  }) : super(key: key);

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final TextEditingController dateController;
  final String labelText;
  final Function(DateTime) onDateSelected;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimens.constraint500,
      child: TextFormField(
        readOnly: true,
        style: TextStyle(
          color: AppColors.of(context).black,
        ),
        decoration: InputDecoration(
          isDense: true,
          labelText: widget.labelText,
          suffixIcon: const Icon(Icons.calendar_today),
          labelStyle: TextStyle(
            color: AppColors.of(context).black,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.of(context).black,
            ),
            borderRadius: BorderRadius.zero,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.of(context).black,
            ),
            borderRadius: BorderRadius.zero,
          ),
        ),
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: widget.initialDate,
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  dialogBackgroundColor: AppColors.of(context).gray,
                  colorScheme: ColorScheme.light(
                    primary: AppColors.of(context).black,
                    onSurface: AppColors.of(context).black,
                  ),
                ),
                child: child!,
              );
            },
          );
          if (picked != null) {
            setState(() {
              widget.dateController.text =
                  '${picked.year}-${picked.month.toString().padLeft(2, '0')}';
              widget.onDateSelected(picked);
            });
          }
        },
        controller: widget.dateController,
      ),
    );
  }
}
