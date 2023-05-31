import 'exception_abs.dart';

abstract class Success {
  final int code;
  final String msg;

  Success({required this.code, required this.msg});

  @override
  String toString() {
    // return "$runtimeType Code:$code\n$msg";
    return "$msg";
  }
}

class ServerSuccess extends Success {
  ServerSuccess({required int code, required String msg})
      : super(code: code, msg: msg);

  factory ServerSuccess.fromResponse(AppException e) {
    return ServerSuccess(code: e.code, msg: e.message);
  }
}

class ActionSuccess extends Success {
  ActionSuccess({required int code, required String msg})
      : super(code: code, msg: msg);

  factory ActionSuccess.fromResponse(AppException e) {
    return ActionSuccess(code: e.code, msg: e.message);
  }
}

