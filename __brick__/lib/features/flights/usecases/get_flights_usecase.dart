import '../../../core/interfaces/base_result.dart';
import '../../../core/interfaces/base_usecase.dart';
import '../domain/entities/flight.dart';
import '../domain/interfaces/flights_repository_interface.dart';

class GetFlightsRequest extends Request {
  @override
  Failure? validate() => null;

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class GetFlightsResponse extends UseCaseResponse {
  final List<Flight> flights;
  GetFlightsResponse(this.flights);
}

class GetFlightsUsecase extends UseCase<GetFlightsResponse, GetFlightsRequest> {
  final FlightsRepositoryInterface repository;

  GetFlightsUsecase({required this.repository});

  @override
  Future<GetFlightsResponse> exec(GetFlightsRequest request) async {
    final flights = await repository.getFlights();
    return GetFlightsResponse(flights);
  }
}
