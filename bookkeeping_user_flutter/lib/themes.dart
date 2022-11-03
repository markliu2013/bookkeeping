import 'package:flutter/material.dart';

final ThemeData lightTheme = _buildLightTheme();
final ThemeData darkTheme = _buildDarkTheme();

ThemeData _buildLightTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    scaffoldBackgroundColor: Colors.white,
    chipTheme: ChipThemeData.fromDefaults(
      secondaryColor: Colors.red,
      brightness: Brightness.light,
      labelStyle: TextStyle(fontSize: 16),
    )
  );
}

ThemeData _buildDarkTheme() {
  final base = ThemeData.dark();
  return base.copyWith(

  );
}
