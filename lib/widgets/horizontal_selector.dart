import 'package:flutter/material.dart';

class HorizontalSelector<T> extends StatefulWidget {
  const HorizontalSelector({
    super.key,
    required this.controller,
    required this.values,
  });

  final ValueNotifier<T> controller;
  final List<HorizontalSelectorItem<T>> values;

  @override
  State<HorizontalSelector<T>> createState() => HorizontalSelectorState<T>();
}

class HorizontalSelectorState<T> extends State<HorizontalSelector<T>> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.values
          .map((HorizontalSelectorItem<T> item) => TextButton(
              onPressed: () {
                setState(() {
                  widget.controller.value = item.value;
                });
              },
              child: Text(
                item.label.toUpperCase(),
                style: TextStyle(
                  decoration: widget.controller.value == item.value
                      ? TextDecoration.underline
                      : null,
                ),
              )))
          .toList(),
    );
  }
}

class HorizontalSelectorItem<T> {
  HorizontalSelectorItem(
    this.label,
    this.value,
  );

  final String label;
  final T value;
}
