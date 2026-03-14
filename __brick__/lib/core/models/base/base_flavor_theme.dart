import 'package:flutter/material.dart';

class BaseFlavorTheme {
  final Color colorSchemaSeed;

  const BaseFlavorTheme({required this.colorSchemaSeed});

  factory BaseFlavorTheme.fromJson(Map<String, dynamic> json) => BaseFlavorTheme(
    colorSchemaSeed: Color(int.parse(json['colorSchemaSeed'])),
  );

  Map<String, dynamic> toJson() => {
    'colorSchemaSeed': '#${colorSchemaSeed.toARGB32()}',
  };
}
