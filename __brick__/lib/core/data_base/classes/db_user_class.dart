import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class UserDB extends HiveObject {

  @HiveField(0)
  int id;

  @HiveField(1)
  String jsonValue;

  UserDB({required this.id,required this.jsonValue});
}


class UserDBAdapter extends TypeAdapter<UserDB> {
  @override
  final typeId = 0;

  @override
  UserDB read(BinaryReader reader) {
    final id = reader.readInt();
    final json = reader.readString();
    return UserDB(id: id,jsonValue: json);
  }

  @override
  void write(BinaryWriter writer, UserDB obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.jsonValue);
  }
}