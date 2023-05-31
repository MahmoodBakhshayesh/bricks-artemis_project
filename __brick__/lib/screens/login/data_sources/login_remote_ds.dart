import 'package:flutter/foundation.dart';
import '../../../core/abstracts/exception_abs.dart';
import '../../../core/abstracts/response_abs.dart';
import '../../../core/constants/apis.dart';
import '../../../core/platform/network_manager.dart';
import '../interfaces/login_data_source_interface.dart';
import '../usecases/login_usecase.dart';
import '../usecases/server_select_usecase.dart';
import 'login_local_ds.dart';

class LoginRemoteDataSource implements LoginDataSourceInterface {
  final LoginLocalDataSource localDataSource = LoginLocalDataSource();
  final NetworkManager networkManager = NetworkManager();

  LoginRemoteDataSource();

  @override
  Future<LoginResponse> login({required LoginRequest request}) async {
    Response res = await networkManager.post(request);
    LoginResponse loginResponse = await compute(LoginResponse.fromResponse,res);
    return loginResponse;
  }

  @override
  Future<ServerSelectResponse> serverSelect({required ServerSelectRequest request}) async {
    Response res = await networkManager.post(request);
    return ServerSelectResponse.fromResponse(res);
  }
}
