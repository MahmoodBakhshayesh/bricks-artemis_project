import '../../../../core/interfaces/base_data_source.dart';
import '../entities/user_entity.dart';
import '../interfaces/login_data_source_interface.dart';

class LoginDataSourceRemote extends RemoteDataSource implements LoginDataSourceInterface {
  LoginDataSourceRemote(super.apiService);

  @override
  Future<UserEntity?> getUserByUsername(String username) {
    // TODO: implement getUserByUsername
    throw UnimplementedError();
  }
}