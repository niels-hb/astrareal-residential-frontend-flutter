import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerFormField extends StatelessWidget {
  DatePickerFormField({
    super.key,
    required this.notifier,
    required this.validator,
    required this.firstDate,
    required this.lastDate,
    required this.decoration,
  });

  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<DateTime?> notifier;
  final String? Function(String?) validator;
  final DateTime firstDate;
  final DateTime lastDate;
  final InputDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: decoration,
      readOnly: true,
      validator: validator,
      onTap: () async {
        final DateTime? dateTime = await showDatePicker(
          context: context,
          initialDate: notifier.value ?? DateTime.now(),
          firstDate: firstDate,
          lastDate: lastDate,
        );

        if (dateTime != null) {
          notifier.value = dateTime;
          _controller.text = DateFormat.yMd().format(dateTime);
        }
      },
    );
  }
}
