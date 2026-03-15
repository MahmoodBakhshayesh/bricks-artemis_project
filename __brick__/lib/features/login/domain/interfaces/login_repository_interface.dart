import '../../usecases/login_usecase.dart';
import '../entities/user_entity.dart';

abstract class LoginRepositoryInterface {
  Future<LoginResponse> login(String username, String password);
  Future<UserEntity?> getUserByUsername(String username);
  UserEntity? loadLoginResponse();
}
