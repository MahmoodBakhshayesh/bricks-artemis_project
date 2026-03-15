import 'dart:developer';
import 'package:get_it/get_it.dart';
import '../../usecases/login_usecase.dart';
import '../entities/user_entity.dart';
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
      remoteDataSource: GetIt.instance.get(instanceName: 'LoginDataSourceRemote'),
      localDataSource: GetIt.instance.get(instanceName: 'LoginDataSourceLocal'),
    );
  }

  @override
  Future<LoginResponse> login(String username, String password) async {
    try {
      final user = await localDataSource.getUserByUsername(username);
      // Basic password check for the mock.
      if (user != null && user.password == password) {
        // In a real app, you would save the session token to local storage here.
        return LoginResponse(success: true, user: user, message: 'Success');
      } else {
        log("$username $password");
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
