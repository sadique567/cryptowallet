import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// class Mytheme {
//   static final light = ThemeData.light().copyWith();
//   static final dark = ThemeData.dark().copyWith();
// }

// ---- LIGHT THEME ----
ThemeData lightTheme() => ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xff007BFF), // Pro blue
    brightness: Brightness.light,
  ),
  primaryColor: const Color(0xff007BFF),
  scaffoldBackgroundColor: const Color(
    0xffFFFFFF,
  ), //const Color.fromARGB(255, 228, 252, 250),
  canvasColor: const Color.fromARGB(240, 250, 250, 250),
  cardColor: const Color.fromARGB(255, 228, 252, 250),
  shadowColor: Colors.grey.withOpacity(0.5),
  brightness: Brightness.light,

  appBarTheme: const AppBarTheme(
    backgroundColor: const Color(0xff007BFF), // Colors.white,
    foregroundColor: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: const Color(0xff007BFF),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff007BFF),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.white, // Color(0xff007BFF),
    unselectedItemColor: const Color.fromARGB(255, 228, 252, 250),
    backgroundColor: const Color(0xff007BFF),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xffF0F2F5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
  ),
);

// ---- DARK THEME ----
ThemeData darkTheme() => ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xffFFB700), // Gold accent
    brightness: Brightness.dark,
  ),
  primaryColor: const Color(0xffFFB700),
  scaffoldBackgroundColor: const Color(0xff121212),
  canvasColor: const Color(0xff1E1E1E),
  cardColor: const Color(0xff1E1E1E),
  shadowColor: Colors.black,
  brightness: Brightness.dark,

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff121212),
    foregroundColor: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff121212),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xffFFB700),
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color(0xffFFB700),
    unselectedItemColor: Colors.grey,
    backgroundColor: Color(0xff1E1E1E),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xff1E1E1E),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.grey, width: 0.8),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
  ),
);
