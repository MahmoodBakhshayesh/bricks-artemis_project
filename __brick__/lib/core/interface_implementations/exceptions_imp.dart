import 'dart:developer';
import '../interfaces/exception_int.dart';

class ServerException extends AppException {
  ServerException({required int code,String? message , required StackTrace trace})
      : super(code: code, message: message??"Unknown Error",trace:trace );
}

class CacheException extends AppException {
  CacheException({ required String message, required StackTrace trace})
      : super(code: -200, message: message,trace:trace);
}

class ParseException extends AppException {
  ParseException({required String message, required StackTrace trace})
      : super(code: -300, message: message,trace:trace);
}


class NoElementException extends AppException {
  NoElementException({required String message, required StackTrace trace})
      : super(code: -300, message: message,trace:trace);
}

class ValidationException extends AppException {
  ValidationException({required String message, required StackTrace trace})
      : super(code: -300, message: message,trace:trace);
}