import 'package:flutter/material.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'utils/theme.dart';
import 'screens/login_screen.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  
  // if (kIsWeb) {
  //   // For web testing
  //   databaseFactory = databaseFactoryFfiWeb;
  // } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
  //   // For desktop testing
  //   sqfliteFfiInit();
  //   databaseFactory = databaseFactoryFfi;
  // }
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
