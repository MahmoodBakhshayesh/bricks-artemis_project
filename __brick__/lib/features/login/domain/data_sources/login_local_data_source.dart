import '../../../../core/database/user/user_entity.dart';
import '../../../../core/interfaces/base_data_source.dart';
import '../interfaces/login_data_source_interface.dart';

class LoginLocalDataSource extends LocalDataSource implements LoginDataSourceInterface {
  LoginLocalDataSource(super.keyValueStore);

  @override
  Future<UserEntity?> getUserByUsername(String username) async {
    // Local data source would check the database.
    await Future.delayed(const Duration(milliseconds: 50));
    return null; // Simulate user not found in local DB.
  }
}
