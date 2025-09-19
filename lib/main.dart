import 'package:data_management_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'utils/theme.dart';

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
      home: const LoginScreen(),
    );
  }
}
