import 'package:flutter/material.dart';
import '../services/auth_services.dart';
import '../utils/validators.dart';
import '../widgets/dialogs.dart';

class SignupController {
  final AuthService _authService = AuthService();

  Future<void> handleSignUp({
    required BuildContext context,
    required String username,
    required String password,
    required Function(String?) onError,
    required Function() onSuccess,
  }) async {
    final usernameError = Validators.validateUsername(username);
    final passwordError = Validators.validatePassword(password);

    if (usernameError != null || passwordError != null) {
      onError(usernameError ?? passwordError);
      return;
    }

    final result = await _authService.registerUser(username, password);

    if (result == null) {
      onSuccess();
      showSuccessDialog(context, 'Account created successfully!');
    } else {
      onError(result);
    }
  }
}
