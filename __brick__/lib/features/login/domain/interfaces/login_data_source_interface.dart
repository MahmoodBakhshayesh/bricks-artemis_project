
import '../../../../core/database/user/user_entity.dart';

abstract class LoginDataSourceInterface {
  Future<UserEntity?> getUserByUsername(String username);
}
