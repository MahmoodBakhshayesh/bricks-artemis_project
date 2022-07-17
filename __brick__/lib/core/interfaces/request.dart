import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../screens/login/login_state.dart';
import '../dependency_injection.dart';
import '../error/failures.dart';

abstract class Request {
  final LoginState loginState = getIt<LoginState>();
  Map<String,dynamic> toJson();
  // T fromJson(Map<String,dynamic> json);

  String? get token => loginState.user?.token;
}