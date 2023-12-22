// models/user.dart
class User {
  final int? id;
  final String identifier;
  final String username;
  final String password;

  User({
    this.id,
    required this.identifier,
    this.username = "",
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'identifier': identifier,
      'username': username,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      identifier: map['identifier'],
      username: map['username'],
      password: map['password'],
    );
  }
}
