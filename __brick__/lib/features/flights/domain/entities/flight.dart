import 'package:flutter/foundation.dart';

@immutable
class Flight {
  final String id;
  final String origin;
  final String destination;
  final DateTime departureTime;

  const Flight({
    required this.id,
    required this.origin,
    required this.destination,
    required this.departureTime,
  });

  // Factory constructor to create a Flight instance from a map
  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json['id'] as String,
      origin: json['origin'] as String,
      destination: json['destination'] as String,
      departureTime: DateTime.parse(json['departureTime'] as String),
    );
  }

  // Method to convert a Flight instance to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'origin': origin,
      'destination': destination,
      'departureTime': departureTime.toIso8601String(),
    };
  }
}

@immutable
class FlightDetails extends Flight {
  final List<String> passengers;

  const FlightDetails({
    required super.id,
    required super.origin,
    required super.destination,
    required super.departureTime,
    required this.passengers,
  });

  // Factory constructor to create a FlightDetails instance from a map
  factory FlightDetails.fromJson(Map<String, dynamic> json) {
    // We can reuse the parent's fromJson logic if we want, but this is explicit.
    return FlightDetails(
      id: json['id'] as String,
      origin: json['origin'] as String,
      destination: json['destination'] as String,
      departureTime: DateTime.parse(json['departureTime'] as String),
      passengers: List<String>.from(json['passengers'] as List),
    );
  }

  // Method to convert a FlightDetails instance to a map
  @override
  Map<String, dynamic> toJson() {
    // Start with the parent's json map
    final json = super.toJson();
    // Add the specific fields for this class
    json['passengers'] = passengers;
    return json;
  }
}
