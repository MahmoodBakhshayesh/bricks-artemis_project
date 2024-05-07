import 'package:dartz/dartz.dart';
import '../../../core/interfaces/failures_int.dart';
import '../usecases/login_usecase.dart';
import '../usecases/server_select_usecase.dart';

abstract class LoginRepositoryInterface {
  Future<Either<Failure, LoginResponse>> login(LoginRequest request);
  Future<Either<Failure, ServerSelectResponse>> serverSelect(ServerSelectRequest request);
}