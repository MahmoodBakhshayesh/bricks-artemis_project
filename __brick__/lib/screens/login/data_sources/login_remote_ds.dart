import '../../../core/interface_implementations/response_imp.dart';
import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../initialize.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../../../core/constants/apis.dart';
import '../../../core/interfaces/network_manager_int.dart';
import '../../../core/interfaces/parser_int.dart';
import '../interfaces/login_data_source_interface.dart';
import '../usecases/login_usecase.dart';
import '../usecases/server_select_usecase.dart';
import 'login_local_ds.dart';

class LoginRemoteDataSource implements LoginDataSourceInterface {
  LoginRemoteDataSource();

  final NetworkManagerImp networkManager = getIt<NetworkManagerImp>();
  final ParserInterface parser = getIt<ParserInterface>();


  @override
  Future<LoginResponse> login({required LoginRequest request}) async {
    ResponseImplementation res = await networkManager.post(request);
    LoginResponse loginResponse = await parser.parse(LoginResponse.fromResponse,res);
    return loginResponse;
  }

  @override
  Future<ServerSelectResponse> serverSelect({required ServerSelectRequest request}) async {
    ResponseImplementation res = await networkManager.post(request);
    ServerSelectResponse serverSelectResponse = await parser.parse(ServerSelectResponse.fromResponse,res);
    return serverSelectResponse;
  }
}
