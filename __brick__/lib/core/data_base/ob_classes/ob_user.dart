import 'dart:convert';
import 'package:objectbox/objectbox.dart';

import '../../classes/user_class.dart';

@Entity()
class OBUser {
  int id;
  String jsonData;

  OBUser({required this.id,required this.jsonData});

  User get toUser {
    return User.fromJson(jsonDecode(jsonData));
  }

  factory OBUser.fromUser(User oUser) {
    return OBUser(id: oUser.id!, jsonData: jsonEncode(oUser.toJson()));
  }
}
