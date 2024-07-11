import 'package:flutter/material.dart';

import 'custom_app_bar.dart';

class SingleFormFieldSelectorPage extends StatelessWidget {
  SingleFormFieldSelectorPage({
    super.key,
    required this.title,
    required this.decoration,
    this.validator,
    String? initial,
    this.keyboardType,
  }) : _controller = TextEditingController(text: initial);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String title;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final InputDecoration decoration;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                Navigator.of(context).pop(_controller.text);
              }
            },
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).cardColor,
        padding: const EdgeInsets.all(32.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: TextFormField(
            controller: _controller,
            validator: validator,
            keyboardType: keyboardType,
            decoration: decoration,
          ),
        ),
      ),
    );
  }
}
