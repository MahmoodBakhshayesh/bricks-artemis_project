import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../navigation/app_routes.dart';

abstract class BaseOverlaysHelper {
  @protected
  BuildContext? get context => AppRoutes.rootContext;

  final alertKey = GlobalKey();

  /// Show a Material dialog.
  Future<T?> showAppDialog<T>(WidgetBuilder builder, {bool barrierDismissible = true, RouteSettings? settings});

  /// Show a confirm dialog; returns true if confirmed.
  Future<bool> confirmDialog({
    required String title,
    required String message,
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    bool barrierDismissible = true,
  });

  /// Show a simple alert dialog.
  Future<void> alertDialog({required String title, required String message, String dismissText = 'Close'});

  /// Show a modal bottom sheet.
  Future<T?> showBottomSheet<T>(
    Widget bottomSheet, {
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool useSafeArea = true,
    bool showDragHandle = false,
    bool useRootNavigator = true,
    RouteSettings? settings,
  });

  /// Show a SnackBar.
  void showSnack(String message, {SnackBarAction? action, Duration? duration});

  /// Show a blocking loading dialog.
  Future<void> showLoading({String message = 'Loading…'});

  void showToast(String title, {String? content, ToastificationType type = ToastificationType.info});
}
