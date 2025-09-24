class Validators {
  static String? validateUsername(String username) {
    if (username.isEmpty) return 'Username cannot be empty.';
    if (username.length < 3) return 'Username must be at least 3 characters.';
    if (username.length > 20) return 'Username must be less than 20 characters.';
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) return 'Password cannot be empty.';
    if (password.length < 6) return 'Password must be at least 6 characters.';
    return null;
  }
}
