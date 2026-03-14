
import '../../../../core/database/user/user_entity.dart';
import '../../../../core/interfaces/base_data_source.dart';
import '../interfaces/login_data_source_interface.dart';

class LoginDataSourceRemote extends RemoteDataSource implements LoginDataSourceInterface {
  LoginDataSourceRemote(super.apiService);

  @override
  Future<UserEntity?> getUserByUsername(String username) {
    // TODO: implement getUserByUsername
    throw UnimplementedError();
  }
}