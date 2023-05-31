import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/classes/user_class.dart';

final loginProvider = ChangeNotifierProvider<LoginState>((_) => LoginState());

class LoginState extends ChangeNotifier {
  void setState() => notifyListeners();

  User? admin;
  TextEditingController usernameC= TextEditingController();
  TextEditingController passwordC= TextEditingController();
  TextEditingController alC= TextEditingController();

  bool loadingLogin = false;

}


final userProvider = StateProvider<User?>((ref) => null);
final adminProvider = StateProvider<User?>((ref) => null);
