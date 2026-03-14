import 'package:get_it/get_it.dart';

import '../../../../core/database/user/user_entity.dart';
import '../../usecases/login_usecase.dart';
import '../interfaces/login_data_source_interface.dart';
import '../interfaces/login_repository_interface.dart';

class LoginRepository implements LoginRepositoryInterface {
  final LoginDataSourceInterface remoteDataSource;
  final LoginDataSourceInterface localDataSource;

  LoginRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  static LoginRepository builder() {
    return LoginRepository(
      remoteDataSource: GetIt.instance.get(instanceName: 'AuthRemoteDataSource'),
      localDataSource: GetIt.instance.get(instanceName: 'AuthLocalDataSource'),
    );
  }

  @override
  Future<LoginResponse> login(String username, String password) async {
    try {
      final user = await remoteDataSource.getUserByUsername(username);
      // Basic password check for the mock.
      if (user != null && user.password == password) {
        // In a real app, you would save the session token to local storage here.
        return LoginResponse(success: true, user: user, message: 'Success');
      } else {
        return LoginResponse(success: false, message: 'Invalid credentials');
      }
    } catch (e) {
      return LoginResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<UserEntity?> getUserByUsername(String username) {
    return remoteDataSource.getUserByUsername(username);
  }

  @override
  UserEntity? loadLoginResponse() {
    // This should ideally come from the local data source.
    return null;
  }
}
