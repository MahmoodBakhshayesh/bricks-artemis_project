import '../entities/user_entity.dart';

abstract class LoginDataSourceInterface {
  Future<UserEntity?> getUserByUsername(String username);
}
