import 'dart:developer';
import 'dart:ui';

import 'package:artemis_utils/artemis_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:network_manager/network_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login/data_sources/login_local_ds.dart';
import '../screens/login/data_sources/login_remote_ds.dart';
import '../screens/login/login_controller.dart';
import '../screens/login/login_repository.dart';
import '../screens/login/login_state.dart';
import 'constants/route_names.dart';
import 'data_base/object_box.dart';
import 'data_base/share_pref.dart';
import 'navigation/navigation_service.dart';
import 'navigation/router.dart';
import 'platform/network_info.dart';
import 'util/image_catcher.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  initNetworkManager();
  // initFullScreen();

  SharedPreferences sp = await SharedPreferences.getInstance();
  ObjectBox objectBox = await ObjectBox.create();
  Connectivity connectivity = Connectivity();
  NetworkInfo networkInfo = NetworkInfo(connectivity);
  MyDeviceInfo deviceInfo = await DeviceUtility.getInfo();

  ImageCatcher imageCatcher = ImageCatcher(sp);
  SharedPrefService sharedPrefService = SharedPrefService(sp);
  NavigationService navigationService = NavigationService();

  getIt.registerSingleton(navigationService);
  getIt.registerSingleton(sharedPrefService);
  getIt.registerSingleton(deviceInfo);
  getIt.registerSingleton(imageCatcher);

  ///login-------------------------------------------------------------------------------------------------------------------

  ///state
  LoginState loginState = LoginState();
  getIt.registerLazySingleton(() => loginState);

  ///data-sources
  LoginLocalDataSource loginLocalDataSource = LoginLocalDataSource(sharedPreferences: sp, objectBox: objectBox);
  LoginRemoteDataSource loginRemoteDataSource = LoginRemoteDataSource(loginLocalDataSource);

  ///repository
  LoginRepository loginRepository = LoginRepository(
    loginRemoteDataSource: loginRemoteDataSource,
    loginLocalDataSource: loginLocalDataSource,
    networkInfo: networkInfo,
  );
  getIt.registerLazySingleton(() => loginRepository);

  ///controller
  LoginController loginController = LoginController();
  getIt.registerLazySingleton(() => loginController);
  navigationService.registerController(RouteNames.login, loginController);


  MyRouter.initialize();
}

void initFullScreen() async {
  // await windowManager.ensureInitialized();
  // windowManager.waitUntilReadyToShow().then((_) async {
  //   // await windowManager.setSkipTaskbar(true);
  //   await windowManager.setTitleBarStyle(TitleBarStyle.normal, windowButtonVisibility: true);
  //   await windowManager.setFullScreen(true);
  // });
}

initNetworkManager() {
  NetworkOption.initialize(
    timeout: 100000000000,
      extraSuccessRule: (NetworkResponse nr) {
    int statusCode = int.parse((nr.responseBody["Status"]?.toString() ?? nr.responseBody["ResultCode"]?.toString() ?? "0"));
    return nr.responseCode ==200 &&  statusCode > 0;
  }, successMsgExtractor: (data) {
    return (data["Message"] ?? data["ResultText"] ?? "Done").toString();
  }, errorMsgExtractor: (data) {
    return (data["Message"] ?? data["ResultText"] ?? "Unknown Error").toString();
  }, tokenExpireRule: (NetworkResponse res) {
    return res.extractedMessage?.contains("Token Expired") ?? false;
  }, onTokenExpire: (NetworkResponse res) {
    // HomeController homeController = getIt<HomeController>();
    // homeController.logout();
  });
}
