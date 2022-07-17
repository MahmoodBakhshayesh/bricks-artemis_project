import 'package:flutter/material.dart';

enum Flavor { abomis }

extension FlavorExtension on Flavor {
  String get name {
    switch (this) {
      case Flavor.abomis:
        return "Abomis";

      default:
        return "Abomis";
    }
  }
}

class AppConfig {
  final Flavor? flavor;
  final ThemeData? lightTheme;
  final ThemeData? darkTheme;
  final String? baseUrl;
  final String? logoAddress;
  static AppConfig? _instance;

  factory AppConfig(
      {required Flavor flavor, ThemeData? lightTheme, ThemeData? darkTheme, required String baseUrl, String? logoAddress}) {
    _instance ??= AppConfig._internal(
        flavor: flavor,
        lightTheme: lightTheme ?? ThemeData.light(),
        darkTheme: darkTheme ?? ThemeData.dark(),
        baseUrl: baseUrl,
        logoAddress: logoAddress);
    return _instance!;
  }

  AppConfig._internal({this.flavor, this.lightTheme, this.darkTheme, this.baseUrl, this.logoAddress});

  static AppConfig? get instance => _instance;

  static ThemeData? get themeLight => _instance!.lightTheme;

  static ThemeData? get themeDark => _instance!.darkTheme;

  static String? get baseURL => _instance!.baseUrl;

  static String? get logo => _instance!.logoAddress;

  static bool get isAbomis => _instance!.flavor == Flavor.abomis;

}
