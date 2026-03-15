import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app.dart';
import 'core/interfaces/base_failure.dart';
import 'core/interfaces/base_result.dart';
import 'di.dart';

void main() {
  /// Initialize Logger
  final appLog = registerLoggerService();

  /// 1. Catch Flutter framework errors (e.g., during build or widget callbacks)
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    appLog.e('Flutter Error', details.exception, details.stack);

    // Emit to FailureBus to show in UI if needed
    FailureBus.I.emit(FailureNotice(
      failure: UnknownFailure(details.exception.toString(), stackTrace: details.stack),
    ));
  };

  GoRouter.optionURLReflectsImperativeAPIs = true; // this config will help to navigate using GoRouter.pushNamed.
  usePathUrlStrategy(); // remove # from browser url

  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      /// 2. Catch platform-level errors (e.g., from native code or top-level async)
      PlatformDispatcher.instance.onError = (error, stack) {
        appLog.e('Platform Error', error, stack);
        FailureBus.I.emit(FailureNotice(
          failure: UnknownFailure(error.toString(), stackTrace: stack),
        ));
        return true;
      };

      /// Set the preferred orientation to portrait
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      await initializeStorages();


      /// Initialize dependencies, including ConfigRepository
      initializeDependencies();
      await initSembast();

      /// Register repositories
      registerGlobalRepositories();

      await initializeAppConfig();

      runApp(const ProviderScope(child: App()));
    },
    (error, stack) {
      /// 3. Catch any other uncaught asynchronous errors within the zone
      appLog.e('Main ERROR (Zoned)');
      appLog.e(error.toString(), error, stack);
      debugPrintStack(stackTrace: stack);

      if (error is FailureNotice) {
        FailureBus.I.emit(error);
      } else {
        FailureBus.I.emit(FailureNotice(
          failure: UnknownFailure(error.toString(), stackTrace: stack),
        ));
      }

      /// Report the error here (Crashlytics/Sentry/etc.)
      /// FirebaseCrashlytics.instance.recordError(error, stack);
    },
  );
}
