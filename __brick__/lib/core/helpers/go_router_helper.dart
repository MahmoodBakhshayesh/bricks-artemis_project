import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../interfaces/base_navigation_service.dart';
import '../navigation/app_routes.dart';

class GoRouterHelper extends BaseNavigationService {
  @override
  void go(String location, {Object? extra}) => context?.go(location, extra: extra);

  @override
  void goNamed(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) => context?.goNamed(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );

  @override
  Future<T?>? push<T>(String location, {Object? extra}) => context?.push<T>(location, extra: extra);

  @override
  Future<T?>? pushNamed<T>(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) => context?.pushNamed<T>(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );

  @override
  void replace(String location, {Object? extra}) => context?.replace(location, extra: extra);

  @override
  void pop<T extends Object?>([T? result]) {
    if (canPop()) {
      try {
        return context?.pop(result);
      } catch (_) {
        if (context != null) return Navigator.of(context!, rootNavigator: true).pop();
      }
    }

    return context?.goNamed(AppRoutes.home);
  }

  @override
  bool canPop() => context?.canPop() ?? false;

  @override
  void replaceNamed(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) {
    return context?.replaceNamed(name, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }
}
