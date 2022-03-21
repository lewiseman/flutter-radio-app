import 'package:flutter/material.dart';

class RadioAppTheme {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
    ),
  );
}
