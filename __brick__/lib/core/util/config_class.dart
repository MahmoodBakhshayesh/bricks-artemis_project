class Config {
  Config({
    required this.appName,
    required this.company,
    required this.baseURL,
  });

  final String appName;
  final String company;
  final String baseURL;

  factory Config.fromJson(Map<String, dynamic> json) => Config(
    appName: json["AppName"],
    company: json["Company"],
    baseURL: json["BaseURL"],
  );

  factory Config.def() => Config(
    appName: 'DCS',
    company: 'Abomis',
    baseURL: 'https://devdatabridge-dcs7.fdcs.ir/dcs',
  );

  Map<String, dynamic> toJson() => {
    "AppName": appName,
    "Company": company,
    "BaseURL": baseURL,
  };
}
