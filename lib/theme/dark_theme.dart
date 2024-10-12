import 'package:flutter/material.dart';

// ThemeData darkTheme = ThemeData.dark(useMaterial3: true,);

// ThemeData darkTheme = ThemeData(
//   brightness: Brightness.dark,
//   useMaterial3: true,
//   colorSchemeSeed: Colors.black
// );

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, elevation: 0, centerTitle: true),
    colorScheme: const ColorScheme.dark(
      surface: Color.fromARGB(255, 26, 26, 26),
      primary: Color.fromARGB(255, 90, 90, 90),
      secondary: Color.fromARGB(182, 124, 124, 124),
      tertiary: Color.fromARGB(255, 39, 39, 39),
      outline: Color.fromARGB(194, 56, 56, 56),
    ));
