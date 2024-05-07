import 'package:flutter/foundation.dart';

abstract class ParserInterface {
  Future<R> parse<M, R>(
    ComputeCallback<M, R> callback,
    M toBeParsed, {
    String? debugLabel,
    String startingErrorMessage = '',
  });
}
