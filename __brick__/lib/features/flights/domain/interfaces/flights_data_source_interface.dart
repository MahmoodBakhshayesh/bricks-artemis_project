import '../entities/flight.dart';

abstract class FlightsDataSourceInterface {
  Future<List<Flight>> getFlights();
  Future<FlightDetails> getFlightDetails(String flightId);
}
