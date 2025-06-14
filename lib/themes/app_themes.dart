import 'package:flutter/material.dart';

class AppThemes {
  static final darkTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 194, 190, 5),
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 194, 190, 5),
      secondary: Color.fromARGB(255, 194, 190, 5),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 194, 190, 5),
      surfaceTintColor: Color.fromARGB(255, 194, 190, 5),
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      elevation: 2,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardColor: const Color(0xFF1E1E1E),
    dividerColor: const Color(0xFF333333),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 16,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF252525),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 194, 190, 5),
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusColor: Color.fromARGB(255, 194, 190, 5),
      labelStyle: TextStyle(color: Color.fromARGB(255, 194, 190, 5)),
      floatingLabelStyle: TextStyle(color: Color.fromARGB(255, 194, 190, 5)),
      suffixIconColor: Color.fromARGB(255, 194, 190, 5),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color.fromARGB(255, 194, 190, 5),
      selectionColor: Color.fromARGB(120, 194, 190, 5),
      selectionHandleColor: Color.fromARGB(255, 194, 190, 5),
    ),
  );

  static final lightTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 194, 190, 5),
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 194, 190, 5),
      secondary: Color.fromARGB(255, 194, 190, 5),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 194, 190, 5),
      surfaceTintColor: Color.fromARGB(255, 194, 190, 5),
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      elevation: 2,
    ),
    scaffoldBackgroundColor: Colors.grey[100],
    cardColor: Colors.white,
    dividerColor: Colors.grey[300],
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: Colors.black87,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.black87,
        fontSize: 16,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
