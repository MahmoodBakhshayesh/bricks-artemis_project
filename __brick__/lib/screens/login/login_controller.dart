import '../../core/abstracts/controller_abs.dart';
import '../../core/abstracts/device_info_service_abs.dart';
import '../../core/classes/new_version_class.dart';
import '../../core/classes/user_class.dart';
import '../../core/navigation/route_names.dart';
import '../../core/platform/device_info.dart';
import '../../core/util/handlers/failure_handler.dart';
import '../../initialize.dart';
import 'login_state.dart';
import 'usecases/login_usecase.dart';

class LoginController extends MainController {
  late LoginState loginState = ref.read(loginProvider);

  Future<User?> login() async {
    User? user;
    DeviceInfoService deviceInfoService = getIt<DeviceInfoService>();
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
