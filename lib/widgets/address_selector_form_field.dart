import 'package:flutter/material.dart';

import '../models/address.dart';
import 'address_selector_page.dart';

class AddressSelectorFormField extends StatelessWidget {
  AddressSelectorFormField({
    super.key,
    required this.notifier,
    required this.decoration,
    this.validator,
  });

  final ValueNotifier<Address?> notifier;
  final TextEditingController _controller = TextEditingController();
  final InputDecoration decoration;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      maxLines: null,
      decoration: decoration,
      validator: validator,
      onTap: () async {
        final Address? address = await Navigator.of(context).push<Address?>(
          MaterialPageRoute<Address?>(
            builder: (BuildContext context) => AddressSelectorPage(
              initial: notifier.value,
            ),
          ),
        );

        if (address != null) {
          notifier.value = address;
          if (context.mounted) {
            _controller.text = address.translate(context);
          }
        }
      },
    );
  }
}
