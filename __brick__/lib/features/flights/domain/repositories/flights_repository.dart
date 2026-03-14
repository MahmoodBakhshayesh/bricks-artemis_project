import 'package:get_it/get_it.dart';

import '../entities/flight.dart';
import '../interfaces/flights_data_source_interface.dart';
import '../interfaces/flights_repository_interface.dart';

class FlightsRepository implements FlightsRepositoryInterface {
  final FlightsDataSourceInterface remoteDataSource;
  final FlightsDataSourceInterface localDataSource;

  FlightsRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  static FlightsRepository builder() {
    return FlightsRepository(
      remoteDataSource: GetIt.instance.get(instanceName: 'FlightsRemoteDataSource'),
      localDataSource: GetIt.instance.get(instanceName: 'FlightsLocalDataSource'),
    );
  }

  @override
  Future<List<Flight>> getFlights() async {
    // In a real app, you'd add logic here:
    // 1. Try to fetch from remoteDataSource.
    // 2. If successful, save the data using localDataSource.
    // 3. If failed, try to load stale data from localDataSource.
    // For now, we'll just delegate to the remote source.
    return remoteDataSource.getFlights();
  }

  @override
  Future<FlightDetails> getFlightDetails(String flightId) {
    return remoteDataSource.getFlightDetails(flightId);
  }
}
