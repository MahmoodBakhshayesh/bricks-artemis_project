import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/classes/user_class.dart';

class LoginState with ChangeNotifier {
  setState() => notifyListeners();

  bool _loginLoading = false;
  bool get loginLoading => _loginLoading;
  void setLoginLoading(bool val) {
    _loginLoading = val;
    notifyListeners();
  }

  String _message = "Hello";
  String get message => _message;
  void setMessage(String msg) {
    _message = msg;
    notifyListeners();
  }

  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  RxString rxTest = "".obs;


  List<User> _users = [];
  List<User> get users => _users;
  void setUsers(List<User> ul) {
    _users = ul;
    notifyListeners();
  }

  User? _user;
  User? get user=>_user;
  void setUser(User? u){
    _user = u;
    notifyListeners();
  }

  Uint8List? imageData;

  bool showPassword = false;

}
