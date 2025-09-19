import 'package:flutter/material.dart';

const Color governmentBlue = Color(0xFF003366);
const Color civicGreen = Color(0xFF2E7D32);
const Color modernGray = Color(0xFF4F4F4F);
const Color digitalCyan = Color(0xFF0288D1);
const Color amberGold = Color(0xFFF9A825);
const Color softNeutralGray = Color(0xFFE0E0E0);
const Color successGreen = Color(0xFF4CAF50);
const Color warningOrange = Color(0xFFFF9800);
const Color errorRed = Color(0xFFD32F2F);
const Color infoBlue1 = Color(0xFF1565C0);
const Color infoBlue2 = Color(0xFF1E88E5);

final ThemeData governmentTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Roboto', // Replace with your preferred font

  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: governmentBlue,
    onPrimary: Colors.white,
    secondary: civicGreen,
    onSecondary: Colors.white,
    error: errorRed,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: modernGray,
  ),

  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: governmentBlue),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: modernGray),
    bodyMedium: TextStyle(fontSize: 16, color: modernGray),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: governmentBlue),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: governmentBlue,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: TextStyle(fontWeight: FontWeight.w600),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: digitalCyan),
    ),
    labelStyle: TextStyle(color: governmentBlue),
    hintStyle: TextStyle(color: modernGray),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: governmentBlue,
    foregroundColor: Colors.white,
    elevation: 2,
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
  ),
);
