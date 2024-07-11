import 'package:flutter/material.dart';

class NovalandBranding {
  Color get _novalandGold => const Color.fromARGB(255, 161, 97, 26);
  Color get _novalandGreen => const Color.fromARGB(255, 142, 205, 65);

  String get title => 'Novaland Residential';

  String get logo => 'assets/images/novaland_logo.jpg';

  ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme(
          background: Colors.grey[200]!,
          brightness: Brightness.light,
          error: Colors.red,
          onBackground: Colors.black,
          onError: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          primary: _novalandGreen,
          secondary: _novalandGold,
          surface: Colors.white,
        ),
        textTheme: TextTheme(
          titleMedium: TextStyle(
            color: _novalandGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: _novalandGreen,
          unselectedItemColor: Colors.black,
        ),
      );

  ThemeData get darkTheme => ThemeData();
}
