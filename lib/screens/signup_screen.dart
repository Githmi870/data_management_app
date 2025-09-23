import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/user.dart';
import '../database/database_helper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  bool _isLoading = false;
  String? _errorMessage;

  // Hash password function
  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  void _handleSignUp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    // Validation
    if (username.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Username cannot be empty.';
      });
      return;
    }

    if (username.length < 3) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Username must be at least 3 characters.';
      });
      return;
    }

    if (username.length > 20) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Username must be less than 20 characters.';
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

    if (password.length < 6) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Password must be at least 6 characters.';
      });
      return;
    }

    try {
      // Check if username already exists
      bool usernameExists = await _databaseHelper.usernameExists(username);
      if (usernameExists) {
        setState(() {
          _isLoading = false;
          _errorMessage =
              'Username already exists. Please choose a different username.';
        });
        return;
      }

      // Create new user
      User newUser = User(
        username: username,
        password: _hashPassword(password),
      );

      // Insert user into database
      int userId = await _databaseHelper.insertUser(newUser);

      if (userId > 0) {
        // Success - show success message and clear form
        setState(() {
          _isLoading = false;
          _errorMessage = null;
        });

        // Clear the form
        _usernameController.clear();
        _passwordController.clear();

        // Show success dialog
        _showSuccessDialog('Account created successfully! User ID: $userId');
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to create account. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'An error occurred: $e';
      });
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Success',
            style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold),
          ),
          content: Text(
            message,
            style: GoogleFonts.jetBrainsMono(),
          ),
          actions: [
            // In _showSuccessDialog, after showing success:
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.pop(context); // Go back to login
              },
              child: Text('Continue to Login'),
            ),
          ],
        );
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
                  onPressed: () => Navigator.pop(context), // Go back to login
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
