import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../core/interface_implementations/network_info.dart';
import '../../initialize.dart';
import 'interfaces/home_repository_interface.dart';
import 'data_sources/home_local_ds.dart';
import 'data_sources/home_remote_ds.dart';

class HomeRepository implements HomeRepositoryInterface {
  final HomeRemoteDataSource homeRemoteDataSource = HomeRemoteDataSource();
  final HomeLocalDataSource homeLocalDataSource = HomeLocalDataSource();
  final NetworkInfo networkInfo = getIt<NetworkInfo>();

  HomeRepository();
}
