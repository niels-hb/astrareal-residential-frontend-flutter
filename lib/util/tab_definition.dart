import 'package:flutter/material.dart';

class TabDefinition {
  TabDefinition({
    required this.title,
    required this.body,
    this.floatingActionButton,
  });

  final String title;
  final Widget body;
  final FloatingActionButton? floatingActionButton;
}
