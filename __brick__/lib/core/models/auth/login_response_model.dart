import '../../helpers/json_validators.dart';

class LoginResponseModel {
  final String token;

  const LoginResponseModel({
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: expectString(json, 'Token'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Token': token,
    };
  }
}

