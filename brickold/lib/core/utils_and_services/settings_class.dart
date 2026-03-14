import 'package:flutter/cupertino.dart';

import '../classes/user_class.dart';

class Settings {
  Settings({
    required this.userSettings,
    required this.systemSettings,
  });

  UserSettings userSettings;
  SystemSettings systemSettings;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        userSettings: UserSettings.fromJson(json["UserSettings"]),
        systemSettings: json["SystemSettings"] == null ? SystemSettings.empty() : SystemSettings.fromJson(json["SystemSettings"]),
      );

  Map<String, dynamic> toJson() => {
        "UserSettings": userSettings.toJson(),
        "SystemSettings": systemSettings.toJson(),
      };

  factory Settings.empty() => Settings(
        userSettings: UserSettings.empty(),
        systemSettings: SystemSettings.empty(),
      );
}

class SystemSettings {
  SystemSettings();

  factory SystemSettings.fromJson(Map<String, dynamic> json) => SystemSettings();

  factory SystemSettings.empty() => SystemSettings();

  Map<String, dynamic> toJson() => {};
}

@immutable
class UserSettings {
  const UserSettings({required this.userInfo});
  final User userInfo;

  factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
        userInfo: User.fromJson(json["UserInfo"]),
      );

  factory UserSettings.empty() => UserSettings(
        userInfo: User.empty(),
      );

  Map<String, dynamic> toJson() => {
        "User": userInfo,
      };
}
