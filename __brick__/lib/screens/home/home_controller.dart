
import '../../core/interfaces/controller_int.dart';
import 'home_state.dart';

class HomeController extends ControllerInterface {
  late HomeState homeState = ref.read(homeProvider);

  void logout() {}
  // UseCase UseCase = UseCase(repository: Repository());

}
