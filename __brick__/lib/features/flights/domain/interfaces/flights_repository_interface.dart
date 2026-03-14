import '../entities/flight.dart';

abstract class FlightsRepositoryInterface {
  Future<List<Flight>> getFlights();
  Future<FlightDetails> getFlightDetails(String flightId);
}
