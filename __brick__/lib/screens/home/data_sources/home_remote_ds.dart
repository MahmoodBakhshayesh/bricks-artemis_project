import '../../../core/interface_implementations/network_manager.dart';
import '../interfaces/home_data_source_interface.dart';
import 'home_local_ds.dart';

class HomeRemoteDataSource implements HomeDataSourceInterface {
  final HomeLocalDataSource localDataSource = HomeLocalDataSource();
  final NetworkManager networkManager = NetworkManager();
  HomeRemoteDataSource();
}
