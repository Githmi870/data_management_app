import 'package:flutter/material.dart';
import 'utils/theme.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CivicData Core',
      theme: governmentTheme,
      home: LoginScreen(),
    );
  }
}
