class User {
  int? id;
  String username;
  String password;

  User({
    this.id,
    required this.username,
    required this.password,
  });

  // Convert User to Map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }

  // Create User from Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
    );
  }
}