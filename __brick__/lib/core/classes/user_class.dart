import 'settings_class.dart';

class User {
  int? id;
  String username;
  String password;
  String token;
  Settings settings;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.token,
    required this.settings,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["ID"]??1,
    username: json["Username"]??"",
    password: json["Password"]??"",
    token: json["Token"],
    settings: Settings.fromJson(json),
  );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> settingJson = settings.toJson();
    settingJson.putIfAbsent("Username", () => username);
    settingJson.putIfAbsent("Password", () => password);
    settingJson.putIfAbsent("ID", () => id);

    return settingJson;
  }


  @override
  String toString() {
    return "ID:$id Username:$username Password:$password Token:$token";
  }

  factory User.example() => User(
    id: 1,
    username: "Test",
    password: "Test",
    token: "TOKEN",
    settings: Settings.fromJson({}),
  );
}