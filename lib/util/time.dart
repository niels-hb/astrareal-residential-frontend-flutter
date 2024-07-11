import 'package:flutter/material.dart';

extension Converter on TimeOfDay {
  DateTime toDateTime() {
    return DateTime.now().copyWith(hour: hour, minute: minute);
  }
}
