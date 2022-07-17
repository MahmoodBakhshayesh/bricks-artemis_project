import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/classes/settings_class.dart';
import '../../../core/classes/user_class.dart';
import '../../../core/data_base/ob_classes/ob_user.dart';
import '../../../core/data_base/object_box.dart';
import '../../../core/error/exception.dart';
import '../interfaces/login_data_source_interface.dart';
import '../usecases/login_usecase.dart';

const String userJsonLocalKey = "UserJson";

class LoginLocalDataSource implements LoginDataSourceInterface {
  final SharedPreferences sharedPreferences;
  final ObjectBox objectBox;

  LoginLocalDataSource({required this.sharedPreferences, required this.objectBox});

  @override
  Future<User> login({required LoginRequest loginRequest}) async{
    return User.example();

    // final box = objectBox.store.box<OBUser>();
    // final query = box.getAll();
    //
    // if (query.isEmpty) {
    //   throw CacheException(message: "User not found!", trace: StackTrace.fromString("LoginLocalDataSource.login"));
    // } else {
    //   User? user = query.first.toUser;
    //   return Future.value(user);
    // }
  }


}
