import '../../../../core/interfaces/base_data_source.dart';
import '../entities/flight.dart';
import '../interfaces/flights_data_source_interface.dart';

class FlightsDataSourceRemote extends RemoteDataSource implements FlightsDataSourceInterface {
  FlightsDataSourceRemote(super.apiService);

  @override
  Future<List<Flight>> getFlights() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Flight(
        id: 'F123 (Remote)',
        origin: 'Remote Airport A',
        destination: 'Remote Airport B',
        departureTime: DateTime.now().add(const Duration(hours: 1)),
      ),
      Flight(
        id: 'F456 (Remote)',
        origin: 'Remote Airport C',
        destination: 'Remote Airport D',
        departureTime: DateTime.now().add(const Duration(hours: 2)),
      ),
      Flight(
        id: 'F789 (Remote)',
        origin: 'Remote Airport E',
        destination: 'Remote Airport F',
        departureTime: DateTime.now().add(const Duration(hours: 3)),
      ),
    ];
  }

  @override
  Future<FlightDetails> getFlightDetails(String flightId) async {
    await Future.delayed(const Duration(seconds: 1));
    return FlightDetails(
      id: flightId,
      origin: 'Remote Airport X',
      destination: 'Remote Airport Y',
      departureTime: DateTime.now().add(const Duration(hours: 4)),
      passengers: [
       "$flightId Passenger 1",
        "$flightId Passenger 2",
        "$flightId Passenger 3"
      ],
    );
  }
}
