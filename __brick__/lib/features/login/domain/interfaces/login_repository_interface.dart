import '../../../../core/database/user/user_entity.dart';
import '../../usecases/login_usecase.dart';

abstract class LoginRepositoryInterface {
  Future<LoginResponse> login(String username, String password);
  Future<UserEntity?> getUserByUsername(String username);
  UserEntity? loadLoginResponse();
}
