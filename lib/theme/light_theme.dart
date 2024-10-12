import 'package:flutter/material.dart';

// ThemeData lightTheme = ThemeData.light(useMaterial3: true,);

// ThemeData lightTheme = ThemeData(
//   brightness: Brightness.light,
//   useMaterial3: true,
//   colorSchemeSeed: Colors.white
// );

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent, elevation: 0, centerTitle: true),
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 221, 221, 221),
    primary: Color.fromARGB(255, 63, 63, 63),
    secondary: Color.fromARGB(247, 202, 202, 202),
    tertiary: Color.fromARGB(255, 225, 225, 225),
    outline: Color.fromARGB(255, 225, 225, 225),
  ),
);
