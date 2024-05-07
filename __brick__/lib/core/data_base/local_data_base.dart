import 'package:isar/isar.dart';

import '../interfaces/local_data_base_int.dart';


class LocalDataBase extends LocalDataSourceInterface {
  @override
  Future<int> addToTable<T>(String tableName, T data) {
    // TODO: implement addToTable
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFromTable<T>(String tableName, key) {
    // TODO: implement deleteFromTable
    throw UnimplementedError();
  }

  @override
  Future<T?> getFromTable<T>(String tableName, key) {
    // TODO: implement getFromTable
    throw UnimplementedError();
  }

  @override
  Future<T?> getFromTableWhere<T>(String tableName, bool Function(T e) rule) {
    // TODO: implement getFromTableWhere
    throw UnimplementedError();
  }

  @override
  Future getKeyOf<T>(String tableName, T val) {
    // TODO: implement getKeyOf
    throw UnimplementedError();
  }

  @override
  Future getKeyWhere<T>(String tableName, bool Function(T a) check) {
    // TODO: implement getKeyWhere
    throw UnimplementedError();
  }

  @override
  Future<void> putToTable<T>(String tableName, key, T updated) {
    // TODO: implement putToTable
    throw UnimplementedError();
  }

}
