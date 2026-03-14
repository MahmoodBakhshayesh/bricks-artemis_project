import 'dart:developer';

import 'request_int.dart';


abstract class AppException implements Exception {
  final int code;
  final String message;
  final StackTrace trace;
  final RequestInterface? request;
  final dynamic data;

  AppException({required this.code, required this.message, required this.trace,this.request,this.data});

  String get traceMsg {
    log(message);
    if (trace.toString().split("#").length > 2) {
      // print(trace.toString());

      String mainTrace = trace.toString().split("#")[1];
      if (trace.toString().contains("fromJson")) {
        mainTrace = trace.toString().split("#").firstWhere((element) => element.contains("fromJson"));
      }
      String mainTraceError = mainTrace.split("(")[0].split("      ")[1].trim();
      String mainTraceAddress = mainTrace.split("/").last.split(".").first;

      String msg = "$mainTraceError in $mainTraceAddress";
      log(trace.toString());
      return msg;
    }
    log(trace.toString());
    return trace.toString();
  }
}

class ServerException extends AppException {
  ServerException({
    required int code,
    String? message,
    required StackTrace trace,
    RequestInterface? request,
    dynamic data,
  }) : super(code: code, message: message ?? "Unknown Error", trace: trace,request: request,data: data);

  @override
  toString()=> message;
}

class CacheException extends AppException {
  CacheException({required String message, required StackTrace trace}) : super(code: -200, message: message, trace: trace);
}

class ParseException extends AppException {
  ParseException({required String message, required StackTrace trace,dynamic data}) : super(code: -300, message: message, trace: trace,data: data);

  @override
  String toString() {
    return message;
  }
}

class NoElementException extends AppException {
  NoElementException({required String message, required StackTrace trace}) : super(code: -300, message: message, trace: trace);
}

class ValidationException extends AppException {
  ValidationException({required String message, required StackTrace trace}) : super(code: -300, message: message, trace: trace);
}
