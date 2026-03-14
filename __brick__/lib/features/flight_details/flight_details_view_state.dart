import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import '../flights/domain/entities/flight.dart';

// This provider is overridden by the router to provide the ID for the current context.
final currentFlightIdProvider = Provider<String>((ref) =>throw UnimplementedError());

// This provider holds the state of the fetched flight details.
final flightDetailsStateProvider = StateProvider<AsyncValue<FlightDetails>>((ref) {
  return const AsyncValue.loading();

});
