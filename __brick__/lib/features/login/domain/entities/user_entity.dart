class UserEntity {
  final String id;
  final String username;
  final String password;
  final String name;
  final String email;

  UserEntity({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.email,
  });

  UserEntity copyWith({
    String? id,
    String? username,
    String? password,
    String? name,
    String? email,
  }) =>
      UserEntity(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        name: name ?? this.name,
        email: email ?? this.email,
      );

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    id: json["id"],
    username: json["username"],
    password: json["password"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "password": password,
    "name": name,
    "email": email,
  };
}