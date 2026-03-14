import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../extensions/context_extension.dart';
import '../interfaces/base_overlays_helper.dart';

/// A responsive implementation of [BaseOverlaysHelper] that delegates to
/// either a mobile or desktop-specific helper based on screen width.
///
/// This class acts as a dispatcher, checking the screen width each time an
/// overlay is requested. This ensures that the UI is always appropriate for the
/// current context, even if the user resizes the window in a web environment.
class AppOverlaysHelper extends BaseOverlaysHelper {
  /// Determines which overlay helper to use based on the current screen width.
  ///
  /// If the screen width is less than 600 logical pixels, it returns an
  /// instance of [_MobileOverlaysHelper]. Otherwise, it returns an instance of
  /// [_DesktopOverlaysHelper].
  BaseOverlaysHelper _getHelper() {
    if (context != null) {
      final width = context!.width;
      if (width < 600) {
        return _MobileOverlaysHelper();
      } else {
        return _DesktopOverlaysHelper();
      }
    }
    // Default to mobile if context is not available.
    return _MobileOverlaysHelper();
  }

  @override
  Future<T?> showAppDialog<T>(WidgetBuilder builder, {bool barrierDismissible = true, RouteSettings? settings}) {
    return _getHelper().showAppDialog(builder, barrierDismissible: barrierDismissible, settings: settings);
  }

  @override
  Future<bool> confirmDialog({
    required String title,
    required String message,
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    bool barrierDismissible = true,
  }) {
    return _getHelper().confirmDialog(
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      barrierDismissible: barrierDismissible,
    );
  }

  @override
  Future<void> alertDialog({required String title, required String message, String dismissText = 'Close'}) {
    return _getHelper().alertDialog(title: title, message: message, dismissText: dismissText);
  }

  @override
  Future<T?> showBottomSheet<T>(
    Widget bottomSheet, {
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool useSafeArea = true,
    bool showDragHandle = false,
    bool useRootNavigator = true,
    RouteSettings? settings,
  }) {
    return _getHelper().showBottomSheet(
      bottomSheet,
      showDragHandle: showDragHandle,
      useRootNavigator: useRootNavigator,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      useSafeArea: useSafeArea,
      settings: settings,
    );
  }

  @override
  void showSnack(String message, {SnackBarAction? action, Duration? duration}) {
    return _getHelper().showSnack(message, action: action, duration: duration);
  }

  @override
  Future<void> showLoading({String message = 'Loading…'}) {
    return _getHelper().showLoading(message: message);
  }

  @override
  void showToast(String title, {String? content, ToastificationType type = ToastificationType.info}) {
    return _getHelper().showToast(title, content: content, type: type);
  }
}

class _MobileOverlaysHelper extends BaseOverlaysHelper {
  @override
  Future<T?> showAppDialog<T>(WidgetBuilder builder, {bool barrierDismissible = true, RouteSettings? settings}) async {
    if (context == null) return null;

    return showDialog<T>(
      context: context!,
      barrierDismissible: barrierDismissible,
      builder: builder,
      routeSettings: settings,
    );
  }

  @override
  Future<bool> confirmDialog({
    required String title,
    required String message,
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    bool barrierDismissible = true,
  }) async {
    final res = await showAppDialog<bool>(
      (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
            child: Text(cancelText),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
    return res ?? false;
  }

  @override
  Future<void> alertDialog({required String title, required String message, String dismissText = 'Close'}) async {
    await showAppDialog<void>(
      (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: Text(dismissText),
          ),
        ],
      ),
    );
  }

  @override
  Future<T?> showBottomSheet<T>(
    Widget bottomSheet, {
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool useSafeArea = true,
    bool showDragHandle = false,
    bool useRootNavigator = true,
    RouteSettings? settings,
  }) async {
    if (context == null) return null;

    return showModalBottomSheet<T>(
      context: context!,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      showDragHandle: showDragHandle,
      isDismissible: isDismissible,
      builder: (c) => bottomSheet,
      routeSettings: settings,
    );
  }

  @override
  void showSnack(String message, {SnackBarAction? action, Duration? duration}) {
    if (context == null) return;

    context!.scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  @override
  Future<void> showLoading({String message = 'Loading…'}) async {
    if (context == null) return;

    return showDialog<void>(
      context: context!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 4),
              const CircularProgressIndicator(),
              const SizedBox(width: 16),
              Flexible(child: Text(message)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void showToast(String title, {String? content, ToastificationType type = ToastificationType.info}) {
    toastification.show(
      title: Text(title),
      autoCloseDuration: const Duration(seconds: 4),
      description: content == null ? null : Text(content),
      type: type,
    );
  }
}

class _DesktopOverlaysHelper extends BaseOverlaysHelper {
  @override
  Future<T?> showAppDialog<T>(WidgetBuilder builder, {bool barrierDismissible = true, RouteSettings? settings}) async {
    if (context == null) return null;

    return showDialog<T>(
      context: context!,
      barrierDismissible: barrierDismissible,
      builder: builder,
      routeSettings: settings,
    );
  }

  @override
  Future<bool> confirmDialog({
    required String title,
    required String message,
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    bool barrierDismissible = true,
  }) async {
    final res = await showAppDialog<bool>(
      (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
            child: Text(cancelText),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
    return res ?? false;
  }

  @override
  Future<void> alertDialog({required String title, required String message, String dismissText = 'Close'}) async {
    await showAppDialog<void>(
      (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: Text(dismissText),
          ),
        ],
      ),
    );
  }

  @override
  Future<T?> showBottomSheet<T>(
    Widget bottomSheet, {
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool useSafeArea = true,
    bool showDragHandle = false,
    bool useRootNavigator = true,
    RouteSettings? settings,
  }) async {
    if (context == null) return null;

    return showModalBottomSheet<T>(
      context: context!,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      showDragHandle: showDragHandle,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      builder: (c) => bottomSheet,
      routeSettings: settings,
    );
  }

  @override
  void showSnack(String message, {SnackBarAction? action, Duration? duration}) {
    if (context == null) return;

    context!.scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  @override
  Future<void> showLoading({String message = 'Loading…'}) async {
    if (context == null) return;

    return showDialog<void>(
      context: context!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 4),
              const CircularProgressIndicator(),
              const SizedBox(width: 16),
              Flexible(child: Text(message)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void showToast(String title, {String? content, ToastificationType type = ToastificationType.info}) {
    toastification.show(
      title: Text(title),
      autoCloseDuration: const Duration(seconds: 4),
      description: content == null ? null : Text(content),
      type: type,
    );
  }
}
