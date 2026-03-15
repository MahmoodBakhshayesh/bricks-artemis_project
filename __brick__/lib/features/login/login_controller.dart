import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/controllers/base_controller.dart';
import '../../core/data/app_data.dart';
import 'login_view_state.dart';
import 'usecases/login_usecase.dart';

final loginControllerProvider = Provider.autoDispose((ref) {
  final loginUsecase = GetIt.instance.get<LoginUsecase>();
  final controller = LoginController(ref, loginUsecase);
  Future.microtask(controller.init);
  ref.onDispose(() => controller.dispose());
  return controller;
});

class LoginController extends BaseController {
  final LoginUsecase _loginUsecase;
  LoginController(super.ref, this._loginUsecase);


  Future<void> login(String username, String password) async {
    logger.i("Attempting login for user: '$username'");
    ref.read(loginErrorMessageProvider.notifier).state = null;
    ref.read(loginIsLoadingProvider.notifier).state = true;

    try {
      final request = LoginRequest(username: username, password: password);
      final loginResponse = await _loginUsecase.exec(request);

      if (loginResponse.success) {
        logger.i("Login successful for user: '$username'");
        ref.read(authenticatedUserProvider.notifier).state = loginResponse.user;
        AppData.instance.setUserId(loginResponse.user!.id);
      } else {
        logger.w("Login failed for user: '$username'. Reason: ${loginResponse.message}");
        ref.read(loginErrorMessageProvider.notifier).state = loginResponse.message;
      }
    } catch (e, st) {
      logger.e("An exception occurred during login for user: '$username'", error: e, stackTrace: st);
      ref.read(loginErrorMessageProvider.notifier).state = e.toString();
    } finally {
      ref.read(loginIsLoadingProvider.notifier).state = false;
    }
  }
}
