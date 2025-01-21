class Config {
  final String baseUrl;
  final String theme;
  final String company;

  Config({
    required this.baseUrl,
    required this.theme,
    required this.company,
  });

  Config copyWith({
    String? baseUrl,
    String? theme,
    String? company,
  }) =>
      Config(
        baseUrl: baseUrl ?? this.baseUrl,
        theme: theme ?? this.theme,
        company: company ?? this.company,
      );

  factory Config.fromJson(Map<String, dynamic> json) => Config(
    baseUrl: json["BaseUrl"],
    theme: json["Theme"],
    company: json["Company"],
  );

  factory Config.def() {
    return Config(baseUrl: 'https://databridgecmprs.fdcs.ir', theme: 'dark', company: 'Abomis');
  }

  Map<String, dynamic> toJson() => {
    "BaseUrl": baseUrl,
    "Theme": theme,
    "Company": company,
  };
}
