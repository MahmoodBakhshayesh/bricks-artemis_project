import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:network_manager/network_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/data_base/classes/db_user_class.dart';
import 'core/data_base/local_data_base.dart';
import 'core/navigation/navigation_service.dart';
import 'core/navigation/route_names.dart';
import 'core/platform/device_info.dart';
import 'core/platform/network_info.dart';
import 'core/util/basic_class.dart';
import 'core/util/config_class.dart';
import 'screens/home/home_controller.dart';
import 'screens/login/login_controller.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDataBase();
  await loadConfigFile();

  getIt.allowReassignment = true;

  Connectivity connectivity = Connectivity();
  NetworkInfo networkInfo = NetworkInfo(connectivity);
  getIt.registerSingleton(networkInfo);

  NavigationService navigationService = NavigationService();
  getIt.registerSingleton(navigationService);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton(sharedPreferences);

  LocalDataBase localDataBase = LocalDataBase();
  getIt.registerSingleton(localDataBase);

  MyDeviceInfo deviceInfo = await DeviceUtility.getInfo();
  DeviceInfoService deviceInfoService = DeviceInfoService(deviceInfo);
  getIt.registerSingleton(deviceInfoService);
}

initControllers() {
  NavigationService ns = getIt<NavigationService>();
  LoginController loginController = LoginController();
  HomeController homeController = HomeController();

  getIt.registerSingleton(loginController);
  getIt.registerSingleton(homeController);

  ns.registerControllers({
    RouteNames.login: loginController,
    RouteNames.home: homeController,
  });
}

void initFullScreen() async {}

initNetworkManager([String? baseUrl]) {
  String base = baseUrl ?? BasicClass.config.baseURL;
  // log("Setting Base URL to $baseUrl");
  NetworkOption.initialize(
      timeout: 100000000000,
      baseUrl: base,
      extraSuccessRule: (NetworkResponse nr) {
        if (nr.responseCode != 200) return false;
        int statusCode = int.parse((nr.responseBody["Status"]?.toString() ?? nr.responseBody["ResultCode"]?.toString() ?? "0"));
        print("Success Check => ${statusCode}");
        return nr.responseCode == 200 && statusCode > 0;
      },
      onStartDefault: (_) {
        final NavigationService navigationService = getIt<NavigationService>();
        navigationService.hideSnackBars();
      },
      successMsgExtractor: (data) {
        return (data["Message"] ?? data["ResultText"] ?? "Done").toString();
      },
      errorMsgExtractor: (data) {
        return (data["Message"] ?? data["ResultText"] ?? "Unknown Error").toString();
      },
      tokenExpireRule: (NetworkResponse res) {
        if (res.responseBody is Map && res.responseBody["Body"] != null) {
          return res.extractedMessage?.contains("Token Expired") ?? false;
        } else {
          return false;
        }
      },
      onTokenExpire: (NetworkResponse res) {
        HomeController homeController = getIt<HomeController>();
        homeController.logout();
      });
}


Future<void> loadConfigFile() async {
  String? directory = (await getApplicationDocumentsDirectory()).path;
  final File file = File('$directory/config/config.json');
  if (file.existsSync()) {
    final jsonStr = file.readAsStringSync();
    try {
      Config config = Config.fromJson(jsonDecode(jsonStr));
      BasicClass.setConfig(config);
      initNetworkManager(config.baseURL);
      log("Config read from config.json");
    } catch (e) {
      await file.create(recursive: true);
      file.writeAsStringSync(json.encode(Config.def().toJson()), mode: FileMode.write);
      BasicClass.setConfig(Config.def());
      initNetworkManager(Config.def().baseURL);
      log("Config read from config.default with exception $e");
    }
  } else {
    await file.create(recursive: true);
    file.writeAsStringSync(json.encode(Config.def().toJson()));
    BasicClass.setConfig(Config.def());
    initNetworkManager(Config.def().baseURL);
    log("Config read from config.default");
  }
}

Future<void> initDataBase() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserDBAdapter());
}
