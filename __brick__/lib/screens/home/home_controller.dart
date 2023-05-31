import '../../core/abstracts/controller_abs.dart';
import '../../core/util/basic_class.dart';
import '../../core/util/handlers/failure_handler.dart';

import 'home_state.dart';

class HomeController extends MainController {
  late HomeState homeState = ref.read(homeProvider);

  void logout() {}
  // UseCase UseCase = UseCase(repository: Repository());

}
