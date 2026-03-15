import '../helpers/api_service.dart';
import 'base_key_value_store.dart';

abstract class BaseDataSource {}

abstract class LocalDataSource extends BaseDataSource {
  final BaseKeyValueStore keyValueStore;
  LocalDataSource(this.keyValueStore);
}

abstract class RemoteDataSource extends BaseDataSource {
  final ApiService apiService;

  RemoteDataSource(this.apiService);
}
