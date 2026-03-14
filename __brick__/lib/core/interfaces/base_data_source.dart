import 'package:objectbox/objectbox.dart';
import '../../di.dart';
import '../database/object_box.dart';
import '../helpers/api_service.dart';
import 'base_key_value_store.dart';

abstract class BaseDataSource {}

abstract class LocalDataSource extends BaseDataSource {
  final ObjectBox _objectBox = locator<ObjectBox>();
  final BaseKeyValueStore keyValueStore;
  Store get store => _objectBox.store;
  LocalDataSource(this.keyValueStore);
}

abstract class RemoteDataSource extends BaseDataSource {
  final ApiService apiService;

  RemoteDataSource(this.apiService);
}
