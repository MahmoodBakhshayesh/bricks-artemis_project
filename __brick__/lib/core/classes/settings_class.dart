class Settings {
  Settings({
    required this.systemSettings,
  });

  SystemSettings systemSettings;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    systemSettings: SystemSettings.fromJson(json["SystemSettings"]),
  );

  Map<String, dynamic> toJson() => {
    "SystemSettings": systemSettings.toJson(),
  };

  factory Settings.empty() => Settings(
    systemSettings: SystemSettings(
    ),
  );
}

class SystemSettings {
  SystemSettings();



  factory SystemSettings.fromJson(Map<String, dynamic> json) => SystemSettings(

  );

  Map<String, dynamic> toJson() => {
  };
}