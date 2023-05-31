import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/abstracts/exception_abs.dart';
import '../../../core/abstracts/local_data_base_abs.dart';
import '../../../core/classes/user_class.dart';
import '../../../core/data_base/local_data_base.dart';
import '../../../core/data_base/table_names.dart';
import '../../../initialize.dart';
import '../interfaces/login_data_source_interface.dart';
import '../usecases/login_usecase.dart';
import '../usecases/server_select_usecase.dart';

const String userJsonLocalKey = "UserJson";

class LoginLocalDataSource implements LoginDataSourceInterface {
  final LocalDataSource localDataSource = getIt<LocalDataBase>();
  final SharedPreferences sharedPreferences = getIt<SharedPreferences>();

  LoginLocalDataSource();

  @override
  Future<LoginResponse> login({required LoginRequest request}) async {
    User? u = await localDataSource.getFromTableWhere<User>(
      TableNames.usersTable,
      (e) => e.username.toLowerCase() == request.username.toLowerCase() && e.password== request.password,
    );
    if (u != null) {
      return LoginResponse(status: 1, message: "Done", user: u);
    } else {
      throw ServerException(code: -1, trace: StackTrace.fromString("Login Failed Check Username and Password"));
    }
  }

  @override
  Future<ServerSelectResponse> serverSelect({required ServerSelectRequest request}) {
    // TODO: implement serverSelect
    throw UnimplementedError();
  }
}
