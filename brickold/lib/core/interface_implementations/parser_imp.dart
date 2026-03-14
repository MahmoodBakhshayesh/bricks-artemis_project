
import 'package:flutter/foundation.dart';

import '../interfaces/exception_int.dart';
import '../interfaces/parser_int.dart';
import 'exceptions_imp.dart';

class Parser implements ParserInterface {
  @override
  Future<R> parse<M, R>(
    ComputeCallback<M, R> callback,
    M toBeParsed, {
    String? debugLabel,
    String startingErrorMessage = '',
  }) async {
    try {
      final R generatedClass = await compute(callback, toBeParsed);
      return generatedClass;
    } catch (e, trace) {
      String? jsonErrorMsg;

      AppException parseException = ParseException(message: jsonErrorMsg ?? e.toString(), trace: trace);
      throw parseException;
    }
  }
}
