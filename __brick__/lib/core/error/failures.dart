
import 'exception.dart';

abstract class Failure {
  final int code;
  final String msg;
  final String traceMsg;

  Failure({required this.code, required this.msg,required this.traceMsg});

  @override
  String toString() {
    return "$runtimeType Code:$code\n$msg\n$traceMsg";
  }
}

class ServerFailure extends Failure {
  ServerFailure({required int code, required String msg, required String traceMsg}) : super(code: code, msg: msg,traceMsg: traceMsg);

  factory ServerFailure.fromAppException(AppException e) {
    return ServerFailure(code: e.code, msg: e.message,traceMsg: e.traceMsg);
  }

}

class CacheFailure extends Failure {
  CacheFailure({required int code, required String msg, required String traceMsg}) : super(code: code, msg: msg,traceMsg: traceMsg);

  factory CacheFailure.fromAppException(AppException e) {
    return CacheFailure(code: e.code, msg: e.message,traceMsg: e.traceMsg);
  }
}

class ValidationFailure extends Failure {
  ValidationFailure({required int code, required String msg, required String traceMsg}) : super(code: code, msg: msg,traceMsg: traceMsg);

  factory ValidationFailure.fromAppException(AppException e) {
    return ValidationFailure(code: e.code, msg: e.message,traceMsg: e.traceMsg);
  }
}

class NoElementFailure extends Failure {
  NoElementFailure({required int code, required String msg, required String traceMsg}) : super(code: code, msg: msg,traceMsg: traceMsg);

  factory NoElementFailure.fromAppException(AppException e) {
    return NoElementFailure(code: e.code, msg: e.message,traceMsg: e.traceMsg);
  }
}
