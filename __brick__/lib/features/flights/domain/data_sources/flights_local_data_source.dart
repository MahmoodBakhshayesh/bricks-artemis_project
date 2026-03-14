import '../../../../core/interfaces/base_data_source.dart';
import '../entities/flight.dart';
import '../interfaces/flights_data_source_interface.dart';

class FlightsLocalDataSource extends LocalDataSource implements FlightsDataSourceInterface {
  FlightsLocalDataSource(super.keyValueStore);

  @override
  Future<List<Flight>> getFlights() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return [
      Flight(id: 'F123 (Local)'),
      Flight(id: 'F456 (Local)'),
      Flight(id: 'F789 (Local)'),
    ];
  }

  @override
  Future<FlightDetails> getFlightDetails(String flightId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return FlightDetails(
      id: flightId,
      passengers: [
        "$flightId Passenger 1",
        "$flightId Passenger 2",
        "$flightId Passenger 3"
      ],
    );
  }
}
