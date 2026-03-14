import 'package:objectbox/objectbox.dart';

@Entity()
class UserEntity {
  @Id()
  int id = 0;

  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? airline;
  String? station;

  @Index()
  @Unique()
  late String username;
  late String password;
}