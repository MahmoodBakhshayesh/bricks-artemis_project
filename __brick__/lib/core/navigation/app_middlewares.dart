import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../data/app_data.dart';

class AppMiddlewares {
  static Future<String?> authRoutesMiddleware(BuildContext context, GoRouterState state) async {
    final bool isLoggedIn = AppData.instance.hasUserId;
    log("isLoggedIn $isLoggedIn");
    final bool isLoggingIn = state.uri.path == '/login';

    // If not logged in and not on login page, redirect to login
    if (!isLoggedIn && !isLoggingIn) {
      return '/login';
    }

    // If logged in and on login page or root, redirect to passengers
    if (isLoggedIn && (isLoggingIn || state.uri.path == '/')) {
      return '/flights';
    }

    return null;
  }
}
