import 'exception_abs.dart';

abstract class Warning {
  final int code;
  final String msg;

  Warning({required this.code, required this.msg});

  @override
  String toString() {
    return "Code:$code\n$msg";
  }
}

class OperationWarning extends Warning {
  OperationWarning({required int code, required String msg})
      : super(code: code, msg: msg);

  factory OperationWarning.fromResponse(AppException e) {
    return OperationWarning(code: e.code, msg: e.message);
  }
}

