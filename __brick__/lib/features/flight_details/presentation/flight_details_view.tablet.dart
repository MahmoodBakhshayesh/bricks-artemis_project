import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../flight_details_controller.dart';
import '../flight_details_view_state.dart';

/// A shared view component that displays the details of a flight,
/// including its passenger list. It is self-contained and gets the flight ID
/// from the `currentFlightIdProvider`.
class FlightDetailsViewTablet extends ConsumerWidget {
  const FlightDetailsViewTablet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(flightDetailsStateProvider);
    final controller = ref.watch(flightDetailsControllerProvider);
    if (controller == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(),
      body: viewState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text('Error: $err')),
        data: (details) => RefreshIndicator(
          onRefresh: controller.getFlightDetails,
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              Center(
                child: Text(
                  'Flight: ${details.id}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const Divider(),
              ...details.passengers.map(
                    (passenger) => ListTile(
                  title: Text(passenger),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
