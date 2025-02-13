import 'package:flutter/material.dart';

class TimePickerFormField extends StatelessWidget {
  TimePickerFormField({
    super.key,
    required this.notifier,
    required this.validator,
    required this.decoration,
  });

  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<TimeOfDay?> notifier;
  final String? Function(String?) validator;
  final InputDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      validator: validator,
      decoration: decoration,
      onTap: () async {
        final TimeOfDay? selected = await showTimePicker(
          context: context,
          initialTime: notifier.value ?? TimeOfDay.now(),
        );

        if (selected != null) {
          notifier.value = selected;
          if (context.mounted) {
            _controller.text = selected.format(context);
          }
        }
      },
    );
  }
}
