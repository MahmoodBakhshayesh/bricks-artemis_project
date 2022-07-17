import 'dart:developer';
import '../../../core/constants/apis.dart';
import '../../../core/error/exception.dart';
import '../../../screens/login/interfaces/login_data_source_interface.dart';
import 'package:network_manager/network_manager.dart';
import '../../../core/classes/user_class.dart';
import '../usecases/login_usecase.dart';
import 'login_local_ds.dart';

class LoginRemoteDataSource implements LoginDataSourceInterface {
  final LoginLocalDataSource localDataSource;

  LoginRemoteDataSource(this.localDataSource);

  @override
  Future<User> login({required LoginRequest loginRequest}) async {
    NetworkRequest loginNR = NetworkRequest(api: Apis.baseUrl, data: loginRequest.toJson(),timeOut: const Duration(days: 1));
    NetworkResponse loginResponse = await loginNR.post();

    if (loginResponse.responseStatus) {
      try {
        User user = User.fromJson(loginResponse.responseBody["Body"]);
        // User user = User.example();

        return user;
      } catch (e, trace) {
        throw ParseException(message: e.toString(), trace: trace);
      }
    } else {
      throw ServerException(
        code: loginResponse.responseCode,
        message: loginResponse.extractedMessage!,
        trace: StackTrace.fromString("LoginRemoteDataSource.login"),
      );
    }
  }

}
