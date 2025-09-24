import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/signup_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  final SignupController _signupController = SignupController();

void _handleSignUp() {
  setState(() {
    _isLoading = true;
    _errorMessage = null;
  });

  _signupController.handleSignUp(
    context: context,
    username: _usernameController.text.trim(),
    password: _passwordController.text,
    onError: (message) {
      setState(() {
        _isLoading = false;
        _errorMessage = message;
      });
    },
    onSuccess: () {
      setState(() {
        _isLoading = false;
      });
      _usernameController.clear();
      _passwordController.clear();
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.data_usage, size: 50, color: Colors.blue),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        'CivicData Core',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Sign Up Here',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  style: GoogleFonts.jetBrainsMono(),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  style: GoogleFonts.jetBrainsMono(),
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    style: GoogleFonts.jetBrainsMono(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignUp,
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Sign Up',
                            style: GoogleFonts.jetBrainsMono(fontSize: 16),
                          ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Already have an account? Sign In',
                    style: GoogleFonts.jetBrainsMono(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
