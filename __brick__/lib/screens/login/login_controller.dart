import 'dart:developer';
import 'package:artemis_utils/artemis_utils.dart';
import '../../core/constants/share_prefrences_keys.dart';
import '../../core/dependency_injection.dart';
import '../../core/interfaces/basic_class.dart';
import '../../core/interfaces/controller.dart';
import '../../core/util/app_config.dart';
import '../../core/util/encryptor.dart';
import '../../core/util/failure_handler.dart';
import '../../screens/login/login_repository.dart';
import 'usecases/login_usecase.dart';
import 'login_state.dart';

class LoginController extends MainController {
  final LoginState loginState = getIt<LoginState>();
  final LoginRepository loginRepository = getIt<LoginRepository>();
  late LoginUseCase loginUseCase = LoginUseCase(repository: loginRepository);

  @override
  void onCreate() {
    loadPreferences();
  }


  void login({required String username, required String password}) async {

    MyDeviceInfo deviceInfo = getIt<MyDeviceInfo>();
    LoginRequest loginRequest = LoginRequest(
      domain: "Windows",
      // domain: "",
      company: deviceInfo.company,
      model: deviceInfo.deviceModel,
      isWifi: true,
      username: username,
      password: password,
      newPassword: password,
      appName: AppConfig.instance!.flavor!.name,
      osVersion: deviceInfo.osVersion,
      versionNum: deviceInfo.versionNumber,
      device: deviceInfo.deviceType,
      deviceId: deviceInfo.deviceKey,
      isApplication: true,
      flavorName: AppConfig.instance!.flavor!.name,
    );
    final fOrUser = await loginUseCase(request: loginRequest);

    fOrUser.fold((f) => FailureHandler.handle(f, retry: () => login(username: username, password: password)), (user) async {
      loginState.setUser(user);
      BasicClass.initialize(user.settings);
      prefs.setString(SpKeys.username, username);
      prefs.setString(SpKeys.password, password);

      ///TODO Login Success
    });
    loginState.setLoginLoading(false);
  }


  loadPreferences() {
    String user = prefs.getString(SpKeys.username) ?? "";
    String pass = prefs.getString(SpKeys.password) ?? "";
    loginState.usernameC.text = user;
    loginState.passwordC.text = pass;
  }

}
