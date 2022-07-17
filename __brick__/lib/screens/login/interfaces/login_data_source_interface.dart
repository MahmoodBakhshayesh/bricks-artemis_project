import '../../../core/classes/user_class.dart';
import '../usecases/login_usecase.dart';

abstract class LoginDataSourceInterface {
  Future<User> login({required LoginRequest loginRequest});
}