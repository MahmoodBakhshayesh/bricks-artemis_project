import 'package:sembast/sembast.dart';

import '../../../../core/database/sembast.dart';
import '../../../../core/interfaces/base_data_source.dart';
import '../entities/user_entity.dart';
import '../interfaces/login_data_source_interface.dart';

class LoginDataSourceLocal extends LocalDataSource implements LoginDataSourceInterface {
  LoginDataSourceLocal(super.keyValueStore);

  @override
  Future<UserEntity?> getUserByUsername(String username) async {
    var finder = Finder(
        filter: Filter.equals('username', username),
        sortOrders: [SortOrder('name')]);

    var records = await SemBastDB.usersTable.find(SemBastDB.instance.db, finder: finder);
    if(records.isEmpty){
      return null;
    }else{
      return UserEntity.fromJson(records.first.value);
    }
  }
}