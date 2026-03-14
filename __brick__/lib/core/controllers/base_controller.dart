import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

/// The base class for all controllers in the application.
abstract class BaseController {
  @protected
  final Ref ref;

  /// A pre-configured logger that automatically includes the controller's class name.
  /// Use this for all logging within controllers to provide clear, contextual output.
  final Logger logger;

  /// The constructor initializes the logger with the runtimeType of the concrete class.
  BaseController(this.ref) : logger = Logger(printer: SimplePrinter(colors: true), output: ConsoleOutput());

  void init() {
    logger.i('Initialized');
  }

  void dispose() {
    logger.i('Disposed');
  }
}
