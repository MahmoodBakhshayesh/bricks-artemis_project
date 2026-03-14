import 'base_flavor_theme.dart';
import 'flavor_config.dart';

class AppConfig {
  final Flavor flavor;
  final String baseUrl;
  final String airlineLogoUrl;
  final bool hasServerSelect;
  final BaseFlavorTheme? theme;
  final BaseFlavorTheme? darkTheme;

  /// The main constructor for the configuration object.
  AppConfig({
    required this.flavor,
    required this.baseUrl,
    required this.airlineLogoUrl,
    required this.hasServerSelect,
    this.theme,
    this.darkTheme,
  });

  AppConfig copyWith({required String baseUrl}) => AppConfig(
    flavor: flavor,
    baseUrl: baseUrl,
    airlineLogoUrl: airlineLogoUrl,
    hasServerSelect: hasServerSelect,
    theme: theme,
    darkTheme: darkTheme,
  );

  factory AppConfig.fromJson(Map<String, dynamic> json) => AppConfig(
    flavor: Flavor.fromString(json['flavor']),
    baseUrl: json['baseUrl'],
    airlineLogoUrl: json['airlineLogoUrl'],
    hasServerSelect: bool.tryParse(json['hasServerSelect'].toString()) ?? false,
  );

  Map<String, dynamic> toJson() => {
    'flavor': flavor.name,
    'baseUrl': baseUrl,
    'airlineLogoUrl': airlineLogoUrl,
    'hasServerSelect': hasServerSelect,
  };
}
