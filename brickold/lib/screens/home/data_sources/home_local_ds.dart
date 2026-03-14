import 'dart:developer';
import '../../../core/interfaces/local_data_base_int.dart';

import '../../../core/classes/user_class.dart';
import '../../../core/data_base/classes/db_user_class.dart';
import '../../../core/data_base/local_data_base.dart';
import '../../../core/data_base/table_names.dart';
import '../../../initialize.dart';
import '../interfaces/home_data_source_interface.dart';

const String userJsonLocalKey = "UserJson";

class HomeLocalDataSource implements HomeDataSourceInterface {
  final LocalDataSourceInterface localDataSource = getIt<LocalDataBase>();
  HomeLocalDataSource();



}
