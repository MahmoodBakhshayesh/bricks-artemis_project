import 'package:dartz/dartz.dart';
import '../../../core/classes/user_class.dart';
import '../../../core/error/failures.dart';
import '../usecases/login_usecase.dart';

abstract class LoginRepositoryInterface {
  Future<Either<Failure, User>> login(LoginRequest request);
}