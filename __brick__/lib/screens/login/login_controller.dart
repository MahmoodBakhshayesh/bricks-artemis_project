import '../../core/classes/new_version_class.dart';
import '../../core/classes/user_class.dart';
import '../../core/interface_implementations/device_info_imp.dart';

import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/device_info_service_int.dart';
import '../../core/navigation/route_names.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../../initialize.dart';
import 'login_state.dart';
import 'usecases/login_usecase.dart';

class LoginController extends ControllerInterface {
  late LoginState loginState = ref.read(loginProvider);

  Future<User?> login() async {
    User? user;
    DeviceInfoServiceImp deviceInfoService = getIt<DeviceInfoServiceImp>();
    DeviceInfo deviceInfo = deviceInfoService.getInfo();

    String username = loginState.usernameC.text;
    String password = loginState.passwordC.text;
    String al = loginState.alC.text;

    LoginUseCase loginUsecase = LoginUseCase();
    LoginRequest loginRequest = LoginRequest(
      username: username,
      password: password,
      newPassword: '',
      deviceInfo: deviceInfo,
      al: al,
      cachedUser: null,
    );
    final fOrR = await loginUsecase(request: loginRequest);

    fOrR.fold((f) => FailureHandler.handle(f, retry: () => login()), (r) {
      user = r.user;
    });
    return user;
  }

  void downloadNewVersion(NewVersion newVersion) {}
}
