import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';

import '../../../core/classes/user_class.dart';
import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';
import '../login_repository.dart';

class LoginUseCase extends UseCase<User,LoginRequest> {
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, User>> call({required LoginRequest request}) {
    return repository.login(request);
  }

}

class LoginRequest extends Request {
  LoginRequest({
    required this.domain,
    required this.company,
    required this.model,
    required this.isWifi,
    required this.username,
    required this.password,
    required this.newPassword,
    required this.appName,
    required this.osVersion,
    required this.versionNum,
    required this.device,
    required this.deviceId,
    required this.isApplication,
    required this.flavorName,
  });

  final String domain;
  final String company;
  final String model;
  final bool isWifi;
  final String username;
  final String password;
  final String newPassword;
  final String appName;
  final String osVersion;
  final String versionNum;
  final String device;
  final String deviceId;
  final bool isApplication;
  final String flavorName;

  @override
  Map<String, dynamic> toJson() =>{
    "Body": {
      "Execution": "Login",
      "Request": {
        "Username": username,
        "Password": password,
        "NewPassword": newPassword,
        "Domain": domain,
        "MotherPassword": false,
        "Company": company,
        "Model": model,
        "IsWifi": isWifi,
        "AppName": appName,
        "OSVersion": osVersion,
        "VersionNum": versionNum,
        "Device": device,
        "DeviceID": deviceId,
        "IsApplication": isApplication,
        "FlavorName": flavorName,
      }
    }
  };
}


