import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../helpers/logger_service.dart';
import '../interfaces/base_failure.dart';
import '../navigation/app_routes.dart';

abstract class FailurePresenter {
  static BuildContext? get _rootContext => AppRoutes.rootContext;

  static void show(FailureNotice n) {
    if (n.extra is Error) {
      appLog.e((n.extra as Error).stackTrace.toString());
    }
    switch (n.severity) {
      case FailureSeverity.info:
        _showSnack(n, bg: Colors.blueAccent);
        break;
      case FailureSeverity.warning:
        _showSnack(n, bg: Colors.orangeAccent);
        break;
      case FailureSeverity.error:
        _showToast(n);
        break;
      case FailureSeverity.critical:
        _showDialog(n);
        break;
    }
  }

  static void _showSnack(FailureNotice n, {required Color bg}) {
    final context = _rootContext;
    if (context == null) {
      appLog.e('No context found for snackbar');
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: bg,
          duration: const Duration(seconds: 6),
          content: Text(n.failure.message),
          action: n.retry == null
              ? null
              : SnackBarAction(
                  label: 'Retry',
                  textColor: Colors.white,
                  onPressed: n.retry!,
                ),
        ),
      );
  }

  static ToastificationItem _showToast(FailureNotice n) {
    return toastification.show(
      autoCloseDuration: const Duration(seconds: 6),
      closeOnClick: true,
      pauseOnHover: true,
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,
      showProgressBar: true,
      title: Text(n.failure.message),
    );
  }

  static void _showDialog(FailureNotice n) {
    final context = _rootContext;
    if (context == null) {
      appLog.e('No context found for dialog');
      return;
    }

    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text('${n.failure}'),
        actions: [
          if (n.retry != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).maybePop();
                n.retry?.call();
              },
              child: const Text('Retry'),
            ),
          TextButton(
            onPressed: () => Navigator.of(context).maybePop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
