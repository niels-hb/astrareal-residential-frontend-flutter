import 'package:flutter/material.dart';

class VinhomesBranding {
  Color get _vinhomesGold => const Color.fromARGB(255, 196, 132, 41);
  Color get _vinhomesBlue => const Color.fromARGB(255, 22, 43, 117);

  String get title => 'Vinhomes Residential';

  String get logo => 'assets/images/vinhomes_logo.png';

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
          primary: _vinhomesGold,
          secondary: _vinhomesBlue,
          surface: Colors.white,
        ),
        textTheme: TextTheme(
          titleMedium: TextStyle(
            color: _vinhomesGold,
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
          selectedItemColor: _vinhomesGold,
          unselectedItemColor: Colors.black,
        ),
      );

  ThemeData get darkTheme => ThemeData(
        colorScheme: ColorScheme(
          background: Colors.black,
          brightness: Brightness.dark,
          error: Colors.red,
          onBackground: Colors.white,
          onError: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          primary: _vinhomesGold,
          secondary: _vinhomesBlue,
          surface: Colors.grey[800]!,
        ),
        textTheme: TextTheme(
          titleMedium: TextStyle(
            color: _vinhomesGold,
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: _vinhomesGold,
          unselectedItemColor: Colors.grey,
        ),
      );
}
