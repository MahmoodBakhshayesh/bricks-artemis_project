import '../../../core/interfaces/failures_int.dart';
import '../usecases/login_usecase.dart';
import '../usecases/server_select_usecase.dart';
import '../../../core/interfaces/result_int.dart';


abstract class LoginRepositoryInterface {
  Future<Result<LoginResponse>> login(LoginRequest request);
  Future<Result<ServerSelectResponse>> serverSelect(ServerSelectRequest request);
}