import 'dart:developer';

abstract class AppException implements Exception {
  final int code;
  final String message;
  final StackTrace trace;
  AppException({required this.code, required this.message,required this.trace});

  String get traceMsg{
    log(message);
    if (trace.toString().split("#").length > 2) {

      String mainTrace = trace.toString().split("#")[1];
      if(trace.toString().contains("fromJson")){
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


