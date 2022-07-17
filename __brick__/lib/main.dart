import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'core/constants/apis.dart';
import 'core/constants/assest.dart';
import 'core/constants/ui.dart';
import 'core/dependency_injection.dart';
import 'core/navigation/navigation_service.dart';
import 'core/util/app_config.dart';
import 'my_app.dart';
import 'screens/login/login_state.dart';


void main()async {
  initializeDateFormatting();
  AppConfig(
      flavor: Flavor.abomis,
      baseUrl: Apis.baseUrl,
      lightTheme: MyTheme.light,
      darkTheme: MyTheme.dark,
      logoAddress: AssetImages.logo
  );
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => getIt<LoginState>()),
    ],
    child: const MyApp(),
  ));
}