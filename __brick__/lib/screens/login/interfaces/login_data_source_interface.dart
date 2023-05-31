import '../usecases/login_usecase.dart';
import '../usecases/server_select_usecase.dart';

abstract class LoginDataSourceInterface {
  Future<LoginResponse> login({required LoginRequest request});
  Future<ServerSelectResponse> serverSelect({required ServerSelectRequest request});
}