import 'package:dartz/dartz.dart';
import '../../../core/abstracts/failures_abs.dart';
import '../usecases/login_usecase.dart';
import '../usecases/server_select_usecase.dart';

abstract class LoginRepositoryInterface {
  Future<Either<Failure, LoginResponse>> login(LoginRequest request);
  Future<Either<Failure, ServerSelectResponse>> serverSelect(ServerSelectRequest request);
}