import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../features/flight_details/flight_details_view.dart';
import '../../features/flight_details/flight_details_view_state.dart';
import '../../features/flights/flights_view.dart';
import '../../features/login/login_view.dart';
import '../data/app_data.dart';
import 'app_middlewares.dart';
import 'app_route_names.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: '/flights',
    refreshListenable: AppData.instance,
    redirect: AppMiddlewares.authRoutesMiddleware,
    routes: [
      GoRoute(
        path: "/login",
        name: AppRouteNames.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/flights',
        name: AppRouteNames.flights,
        builder: (context, state) => const FlightsView(),
        routes: [
          GoRoute(
            path: ':id/details',
            name: AppRouteNames.flightDetails,
            builder: (context, state) {
              final flightId = state.pathParameters['id']!;
              return ProviderScope(
                overrides: [
                  currentFlightIdProvider.overrideWithValue(flightId),
                ],
                child: FlightDetailsView(),
              );
            },
          ),
        ],
      ),
    ],
  );
});
