import 'dart:developer';
import 'package:brs_panel/initialize.dart';
import 'package:dartz/dartz.dart';
import '../../core/abstracts/exception_abs.dart';
import '../../core/abstracts/failures_abs.dart';
import '../../core/platform/network_info.dart';
import 'interfaces/login_repository_interface.dart';
import 'data_sources/login_local_ds.dart';
import 'data_sources/login_remote_ds.dart';
import 'usecases/login_usecase.dart';
import 'usecases/server_select_usecase.dart';

class LoginRepository implements LoginRepositoryInterface {
  final LoginRemoteDataSource loginRemoteDataSource = LoginRemoteDataSource();
  final LoginLocalDataSource loginLocalDataSource = LoginLocalDataSource();
  final NetworkInfo networkInfo = getIt<NetworkInfo>();

  LoginRepository();

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest request) async {
    try {
      LoginResponse loginResponse;
      if (await networkInfo.isConnected) {
        loginResponse = await loginRemoteDataSource.login(request: request);
      } else {
        loginResponse = await loginLocalDataSource.login(request: request);
      }
      return Right(loginResponse);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Either<Failure, ServerSelectResponse>> serverSelect(ServerSelectRequest request) async {
    try {
      ServerSelectResponse serverSelectResponse;
      if (await networkInfo.isConnected) {
        serverSelectResponse = await loginRemoteDataSource.serverSelect(request: request);
      } else {
        serverSelectResponse = await loginLocalDataSource.serverSelect(request: request);
      }
      return Right(serverSelectResponse);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }
  }
}
