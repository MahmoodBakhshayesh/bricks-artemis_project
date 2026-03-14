import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../extensions/theme_extension.dart';
import '../models/base/flavor_config.dart';

import 'app_colors.dart';

class AppTheme {
  static final borderRadius = BorderRadius.circular(12);
  static final dialogBorderRadius = BorderRadius.circular(24);

  static ThemeData get theme => ThemeData(
    colorSchemeSeed: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    pageTransitionsTheme: PageTransitionsTheme(
      builders: TargetPlatform.values
          .map((e) => {e: const CupertinoPageTransitionsBuilder()})
          .fold({}, (keys, values) => {...keys, ...values}),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: dialogBorderRadius),
    ),
    appBarTheme: const AppBarThemeData(
      centerTitle: false,
      backgroundColor: AppColors.appBarBackground,
      foregroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(),
    ),
  ).merge(appConfig.theme);
}
