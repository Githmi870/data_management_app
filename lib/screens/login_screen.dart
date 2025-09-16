import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_button.dart';
// import '../utils/validators.dart';
// import '../services/auth_services.dart';
// import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Username cannot be empty.';
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Password cannot be empty.';
      });
      return;
    }

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome Back',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
            CustomTextField(
              hintText: 'Username',
              controller: _usernameController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: 'Password',
              controller: _passwordController,
              isPassword: true,
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),
            LoadingButton(
              text: 'Login',
              isLoading: _isLoading,
              onPressed: _handleLogin
            ),
          ],
        ),
      ),
    );
  }
}