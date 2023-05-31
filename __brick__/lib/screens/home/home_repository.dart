import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../core/abstracts/exception_abs.dart';
import '../../core/abstracts/failures_abs.dart';
import '../../core/platform/network_info.dart';
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
