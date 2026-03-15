import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';
import '../../di.dart';
import '../../features/flights/domain/entities/flight.dart';
import '../../features/login/domain/entities/user_entity.dart';

class SemBastDB {
  SemBastDB._();

  static late Database _db;
  static final SemBastDB instance = SemBastDB._();
  Database get db =>_db;
  static Future<SemBastDB> init([String? name]) async {
    String dbName = name??'app.db';
    if(kIsWeb) {
      var factory = databaseFactoryWeb;
      var db = await factory.openDatabase(dbName);
      _db = db;
    }else{
      final appDir = await getApplicationDocumentsDirectory();
      await appDir.create(recursive: true);
      final dbPath = join(appDir.path, dbName);
      final database = await databaseFactoryIo.openDatabase(dbPath);
      _db = database;
    }
    await SemBastDB.seedDatabase();
    return instance;
  }

  static StoreRef<String, Map<String, Object?>> get flightTable => stringMapStoreFactory.store('flights');
  static StoreRef<String, Map<String, Object?>> get usersTable => stringMapStoreFactory.store('users');
  static StoreRef<String, Map<String, Object?>> get flightDetailsTable => stringMapStoreFactory.store('flightDetails');

  static Future<void> seedDatabase() async {
    if ((await usersTable.count(_db)) <2) {
      final usersSeed = [
        UserEntity(username: 'admin', password: 'admin', name: 'admin user', email: 'admin@admin.co', id: '0'),
        UserEntity(username: 'test', password: 'test', name: 'test user', email: 'test@test.co', id: '1'),
      ];
      await usersTable.addAll(_db, usersSeed.map((a) => a.toJson()).toList());
    }
    if ((await flightTable.count(_db)) ==0) {
      final flightSeeds = [
        Flight(id: "01", origin: "sem", destination: "bast", departureTime: DateTime.now()),
        Flight(id: "02", origin: "bast", destination: "sem", departureTime: DateTime.now())
      ];
      await flightTable.addAll(_db, flightSeeds.map((a) => a.toJson()).toList());
    }
  }
}
