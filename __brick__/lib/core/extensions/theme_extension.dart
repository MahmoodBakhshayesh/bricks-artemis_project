import 'package:flutter/material.dart';
import '../models/base/base_flavor_theme.dart';

extension ThemeExtension on ThemeData {
  ThemeData merge(BaseFlavorTheme? theme) {
    if (theme == null) return this;

    return copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: theme.colorSchemaSeed),
    );
  }
}
