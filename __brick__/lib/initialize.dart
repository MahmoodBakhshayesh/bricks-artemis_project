import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../core/interfaces/network_info_int.dart';
import '../../core/utils_and_services/app_config.dart';
import '../../core/utils_and_services/app_data.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/classes/config_class.dart';
import 'core/data_base/classes/db_user_class.dart';
import 'core/data_base/local_data_base.dart';
import 'core/interface_implementations/device_info_imp.dart';
import 'core/interface_implementations/network_info_imp.dart';
import 'package:network_manager/network_manager.dart';
import 'core/interface_implementations/parser_imp.dart';
import 'core/interface_implementations/shared_preferences_imp.dart';
import 'core/interfaces/parser_int.dart';
import 'core/interfaces/shared_preferences_int.dart';
import 'core/navigation/routes.dart';
import 'screens/home/home_controller.dart';
import 'screens/login/login_controller.dart';
import 'core/interface_implementations/network_manager_imp.dart';



final getIt = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.allowReassignment = true;

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesInterface sp = SharedPreferencesImp();
  getIt.registerFactory(() => sp);

  await _initDataBase();
  await _initConfig();
  await _initPackages();

}

initControllers() {
  LoginController loginController = LoginController();
  HomeController homeController = HomeController();

  getIt.registerSingleton(loginController);
  getIt.registerSingleton(homeController);

}

void initFullScreen() async {}

initNetworkManager([String? baseUrl]) {
  String base = baseUrl ?? AppData.config!.baseUrl;
  // log("Setting Base URL to $baseUrl");
  NetworkOption.initialize(
      timeout: const Duration(milliseconds: 30000),
      baseUrl: base,
      successCheck: (NetworkRequest req,NetworkResponse res) {
        if (res.responseCode != 200) return false;
        int statusCode = int.parse((res.responseBody["Status"]?.toString() ?? res.responseBody["ResultCode"]?.toString() ?? "0"));
        return res.responseCode == 200 && statusCode > 0;
      },
      onStartDefault: (_) {
      },
      msgExtractor: (data) {
        return (data["Message"] ?? data["ResultText"] ?? "Done").toString();
      },
      tokenExpireCheck: (NetworkRequest req,NetworkResponse res) {
        if (res.responseBody is Map && res.responseBody["Body"] != null) {
          return res.extractedMessage?.contains("Token Expired") ?? false;
        } else {
          return false;
        }
      },
      onTokenExpire: (NetworkRequest req,NetworkResponse res) {
        HomeController homeController = getIt<HomeController>();
        homeController.logout();
      });
}


Future<void> _initConfig() async {
  String? directory = (await getApplicationDocumentsDirectory()).path;
  final File file = File('$directory/config/config.json');
  if (file.existsSync()) {
    final jsonStr = file.readAsStringSync();
    try {
      Config config = Config.fromJson(jsonDecode(jsonStr));
      AppData.setConfig(config);
      initNetworkManager(config.baseUrl);
      log("Config read from config.json");
    } catch (e) {
      await file.create(recursive: true);
      file.writeAsStringSync(json.encode(Config.def().toJson()), mode: FileMode.write);
      AppData.setConfig(Config.def());
      initNetworkManager(Config.def().baseUrl);
      log("Config read from config.default with exception $e");
    }
  } else {
    await file.create(recursive: true);
    file.writeAsStringSync(json.encode(Config.def().toJson()));
    AppData.setConfig(Config.def());
    initNetworkManager(Config.def().baseUrl);
    log("Config read from config.default");
  }
}

Future<void> _initDataBase() async {

}

Future<void> _initPackages() async {
  Connectivity connectivity = Connectivity();
  NetworkInfoImp networkInfo = NetworkInfoImp(connectivity);
  getIt.registerSingleton(networkInfo);

  NetworkManagerImp networkManager = NetworkManagerImp();
  getIt.registerSingleton(networkManager);



  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton(sharedPreferences);

  LocalDataBase localDataBase = LocalDataBase();
  getIt.registerSingleton(localDataBase);

  MyDeviceInfo deviceInfo = await DeviceUtility.getInfo();
  DeviceInfoServiceImp deviceInfoService = DeviceInfoServiceImp(deviceInfo);
  getIt.registerSingleton(deviceInfoService);

  ParserInterface parser = Parser();
  getIt.registerSingleton(parser);
}
