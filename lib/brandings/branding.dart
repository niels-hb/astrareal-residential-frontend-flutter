import 'package:flutter/material.dart';

import 'customer.dart';
import 'novaland_branding.dart';
import 'vinhomes_branding.dart';

class Branding extends InheritedWidget {
  factory Branding({
    required Customer customer,
    required Widget child,
  }) {
    switch (customer) {
      case Customer.vinhomes:
        final VinhomesBranding vinhomesBranding = VinhomesBranding();

        return Branding._internal(
          title: vinhomesBranding.title,
          logo: vinhomesBranding.logo,
          lightTheme: vinhomesBranding.lightTheme,
          darkTheme: vinhomesBranding.darkTheme,
          child: child,
        );
      case Customer.novaland:
        final NovalandBranding novalandBranding = NovalandBranding();

        return Branding._internal(
          title: novalandBranding.title,
          logo: novalandBranding.logo,
          lightTheme: novalandBranding.lightTheme,
          darkTheme: novalandBranding.darkTheme,
          child: child,
        );
    }
  }

  const Branding._internal({
    required this.title,
    required this.logo,
    required this.lightTheme,
    required this.darkTheme,
    required super.child,
  });

  final String title;
  final String logo;
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  static Branding of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Branding>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
