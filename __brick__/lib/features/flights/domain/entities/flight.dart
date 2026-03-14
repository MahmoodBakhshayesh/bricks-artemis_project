
class Flight {
  final String id;

  Flight({required this.id});
}

class FlightDetails extends Flight {
  final List<String> passengers;

  FlightDetails({required super.id, required this.passengers});
}
