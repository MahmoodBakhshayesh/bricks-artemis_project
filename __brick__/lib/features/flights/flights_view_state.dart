import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'domain/entities/flight.dart';

final flightsStateProvider = StateProvider<AsyncValue<List<Flight>>>((ref) {
  return const AsyncValue.loading();
});
