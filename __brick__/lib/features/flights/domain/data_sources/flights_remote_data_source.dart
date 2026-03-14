import '../../../../core/interfaces/base_data_source.dart';
import '../entities/flight.dart';
import '../interfaces/flights_data_source_interface.dart';

class FlightsRemoteDataSource extends RemoteDataSource implements FlightsDataSourceInterface {
  FlightsRemoteDataSource(super.apiService);

  @override
  Future<List<Flight>> getFlights() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Flight(id: 'F123 (Remote)'),
      Flight(id: 'F456 (Remote)'),
      Flight(id: 'F789 (Remote)'),
    ];
  }

  @override
  Future<FlightDetails> getFlightDetails(String flightId) async {
    await Future.delayed(const Duration(seconds: 1));
    return FlightDetails(
      id: flightId,
      passengers: [
       "Passenger 1",
        "Passenger 2",
        "Passenger 3"
      ],
    );
  }
}
