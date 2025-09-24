class User {
  final int? userId;
  final String username;
  final String password;

  User({this.userId, required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'UserId': userId,
      'Username': username,
      'Password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['UserId'],
      username: map['Username'],
      password: map['Password'],
    );
  }
}
