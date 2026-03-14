import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import '../../di.dart';

class LoggerService {
  final Level logLevel;

  LoggerService({this.logLevel = Level.all}) {
    _logger = Logger(level: logLevel, printer: SimplePrinter());
  }

  late final Logger _logger;

  void d(Object message) => _logger.d(message);

  void i(Object message) => _logger.i(message);

  void w(Object message) => _logger.w(message);

  void e(Object message, [Object? error, StackTrace? stackTrace]) => _logger.e(message, error: error, stackTrace: stackTrace);
}

mixin LoggerServiceHelperMixin {
  LoggerService get log => appLog;

  @protected
  void logD(String msg) => appLog.d('[$runtimeType] $msg');

  @protected
  void logI(String msg) => appLog.i('[$runtimeType] $msg');

  @protected
  void logW(String msg) => appLog.w('[$runtimeType] $msg');

  @protected
  void logE(String msg, [Object? e, StackTrace? st]) => appLog.e('[$runtimeType] $msg', e, st);
}

final appLog = locator<LoggerService>();
