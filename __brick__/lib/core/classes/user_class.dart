import 'package:flutter/foundation.dart';

@immutable
class User {
  final int id;
  final String username;
  final String password;
  final String token;

  const User({
    required this.id,
    required this.username,
    required this.password,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["ID"],
      username: json["Username"],
      password: json["Password"],
      token: json["Token"],
    );
  }


  factory User.empty() {
    return User(
      id: 0,
      username: "Test",
      password: "Pass",
      token: "123",
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "ID":id,
      "Username":username,
      "Password":password,
      "Token":token
    };
  }

  @override
  bool operator ==(Object other) => other is User && username == other.username;

  @override
  int get hashCode => username.hashCode;

}
