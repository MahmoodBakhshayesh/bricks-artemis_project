import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../core/classes/settings_class.dart';
import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import '../../core/platform/network_info.dart';
import '../../screens/login/interfaces/login_repository_interface.dart';
import '../../core/classes/user_class.dart';
import 'data_sources/login_local_ds.dart';
import 'data_sources/login_remote_ds.dart';
import 'usecases/login_usecase.dart';

class LoginRepository implements LoginRepositoryInterface {
  final LoginRemoteDataSource loginRemoteDataSource;
  final LoginLocalDataSource loginLocalDataSource;
  final NetworkInfo networkInfo;

  LoginRepository({required this.loginRemoteDataSource, required this.loginLocalDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, User>> login(LoginRequest loginRequest) async {
    if (await networkInfo.isConnected) {
      try {
        User user = await loginRemoteDataSource.login(loginRequest: loginRequest);
        return Right(user);
      }  on AppException catch (e){
        return Left(ServerFailure.fromAppException(e));
      }
    } else {
      try {
        User user = await loginLocalDataSource.login(loginRequest:loginRequest);
        return Right(user);
      } on AppException catch (e){
        return Left(CacheFailure.fromAppException(e));
      }
    }
  }



}
