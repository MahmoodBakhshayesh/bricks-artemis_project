import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/constants/apis.dart';
import 'core/constants/assest.dart';
import 'core/constants/ui.dart';
import 'core/util/app_config.dart';
import 'initialize.dart';
import 'my_app.dart';

void main() async {
  AppConfig(
      flavor: Flavor.abomis,
      baseUrl: Apis.baseUrl,
      lightTheme: MyTheme.lightAbomis,
      darkTheme: MyTheme.lightAbomis,
      logoAddress: AssetImages.logo
  );
  await init();
  runApp( const ProviderScope(child: MyApp()));
}
