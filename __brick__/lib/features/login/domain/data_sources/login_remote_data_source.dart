import '../../../../core/database/user/user_entity.dart';
import '../../../../core/helpers/api_service.dart';
import '../../../../core/interfaces/base_data_source.dart';
import '../interfaces/login_data_source_interface.dart';

class LoginRemoteDataSource extends RemoteDataSource implements LoginDataSourceInterface {
  LoginRemoteDataSource(super.apiService);

  @override
  Future<UserEntity?> getUserByUsername(String username) async {
    // Simulate a network call for authentication.
    await Future.delayed(const Duration(seconds: 1));
    if (username == 'test') {
      UserEntity  u= UserEntity();
      u.username = username;
      u.password = 'test';
      u.id = 1;
      return u;
    } else {
      return null;
    }
  }
}
