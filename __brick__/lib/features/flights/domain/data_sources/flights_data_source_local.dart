import '../entities/flight.dart';
import '../interfaces/flights_data_source_interface.dart';

class FlightsDataSourceLocal implements FlightsDataSourceInterface {
  @override
  Future<List<Flight>> getFlights() async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      Flight(id: 'F123'),
      Flight(id: 'F456'),
      Flight(id: 'F789'),
    ];
  }

  @override
  Future<FlightDetails> getFlightDetails(String flightId) async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1));
    return FlightDetails(
      id: flightId,
      passengers: [

      ],
    );
  }
}
