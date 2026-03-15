import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

import '../../../../core/database/sembast.dart';
import '../../../../core/interfaces/base_data_source.dart';
import '../entities/flight.dart';
import '../interfaces/flights_data_source_interface.dart';

class FlightsDataSourceLocal  extends LocalDataSource  implements FlightsDataSourceInterface {
  // final SemBastDB _database;
  FlightsDataSourceLocal(super.keyValueStore);


  @override
  Future<List<Flight>> getFlights() async {
    final snapshots = await SemBastDB.flightTable.find(SemBastDB.instance.db);
    return snapshots.map((snapshot) => Flight.fromJson(snapshot.value)).toList(growable: false);
  }

  @override
  Future<FlightDetails> getFlightDetails(String flightId) async {
    throw UnimplementedError();
    // final snapshot = await _store.record(flightId).get(_database);
    // if (snapshot == null) {
    //   // Or handle this case with a specific error/exception
    //   throw Exception('Flight with ID $flightId not found in local database.');
    // }
    // return FlightDetails.fromJson(snapshot);
  }
}
