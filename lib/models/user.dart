class User {
  final String username;
  final String? password;

  User({required this.username, this.password});

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };
}