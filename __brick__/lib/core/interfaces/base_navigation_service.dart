import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';

/// An abstract interface for handling navigation within the app.
///
/// This class defines a standard set of navigation methods that can be
/// implemented by a concrete router, such as go_router. This abstraction
/// allows the rest of the app to remain decoupled from the specific
/// navigation library being used.
abstract class BaseNavigationService {
  /// Provides access to the root BuildContext of the app.
  ///
  /// This can be useful for showing dialogs or other UI elements that need
  /// a context but are called from outside the widget tree.
  BuildContext? get context => AppRoutes.rootContext;

  /// Navigates to a new location in the app.
  ///
  /// This is typically used for routes that are part of the main navigation flow.
  /// The [extra] parameter can be used to pass data to the new route.
  void go(String location, {Object? extra});

  /// Navigates to a new location using a named route.
  ///
  /// This provides a more type-safe way to navigate, as it relies on route names
  /// rather than raw string paths.
  void goNamed(String name, {Map<String, String> pathParameters = const {}, Map<String, dynamic> queryParameters = const {}, Object? extra});

  /// Pushes a new route onto the navigation stack.
  ///
  /// This is useful for opening a new screen that should appear on top of the
  /// current one, like a detail page.
  Future<T?>? push<T>(String location, {Object? extra});

  /// Pushes a new route onto the navigation stack using a named route.
  Future<T?>? pushNamed<T>(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  });

  /// Replaces the current route with a new one.
  ///
  /// This is useful for scenarios like login, where you want to replace the
  /// login screen with the home screen.
  void replace(String location, {Object? extra});

  void replaceNamed(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  });

  /// Pops the current route off the navigation stack.
  ///
  /// If [result] is provided, it will be returned to the previous route.
  void pop<T extends Object?>([T? result]);

  /// Checks if it's possible to pop the current route.
  ///
  /// This is useful for determining whether to show a back button in the UI.
  bool canPop();
}
