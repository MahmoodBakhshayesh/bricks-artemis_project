import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/navigation/app_route_names.dart';
import '../domain/entities/flight.dart';
import '../flights_controller.dart';
import '../flights_view_state.dart';

/// The phone-specific layout for the Flights screen.
class FlightsViewDesktop extends ConsumerWidget {
  const FlightsViewDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(flightsStateProvider);
    final controller = ref.watch(flightsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flights (Phone)'),
        actions: [
          IconButton(
            onPressed: controller.getFlights,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: viewState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (flights) => _FlightsList(flights: flights),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _FlightsList extends StatelessWidget {
  final List<Flight> flights;
  const _FlightsList({required this.flights});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: flights.length,
      itemBuilder: (context, index) {
        final flight = flights[index];
        return ListTile(
          title: Text(flight.id),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  context.goNamed(AppRouteNames.flightDetails, pathParameters: {'id': flight.id});
                },
                child: const Text('Details'),
              ),

            ],
          ),
        );
      },
    );
  }
}
