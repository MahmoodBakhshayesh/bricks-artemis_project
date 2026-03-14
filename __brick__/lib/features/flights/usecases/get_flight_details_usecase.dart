import '../../../core/interfaces/base_result.dart';
import '../../../core/interfaces/base_usecase.dart';
import '../domain/entities/flight.dart';
import '../domain/interfaces/flights_repository_interface.dart';

class GetFlightDetailsRequest extends Request {
  final String flightId;
  GetFlightDetailsRequest(this.flightId);

  @override
  Failure? validate() => null;

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class GetFlightDetailsResponse extends UseCaseResponse {
  final FlightDetails flightDetails;
  GetFlightDetailsResponse(this.flightDetails);
}

class GetFlightDetailsUsecase extends UseCase<GetFlightDetailsResponse, GetFlightDetailsRequest> {
  final FlightsRepositoryInterface repository;

  GetFlightDetailsUsecase({required this.repository});

  @override
  Future<GetFlightDetailsResponse> exec(GetFlightDetailsRequest request) async {
    final details = await repository.getFlightDetails(request.flightId);
    return GetFlightDetailsResponse(details);
  }
}
