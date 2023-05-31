import 'package:hive/hive.dart';
import '../abstracts/local_data_base_abs.dart';
import 'classes/db_user_class.dart';

class LocalDataBase extends LocalDataSource {
  ///create
  @override
  Future<int> addToTable<T>(String tableName, T data) async {
    final box = await Hive.openBox<T>(tableName);
    final res = await box.add(data);
    await box.close();
    return res;
  }

  ///read
  @override
  Future<T?> getFromTable<T>(String tableName, dynamic key) async {
    try {
      final box = await Hive.openBox<T>(tableName);

      if (box.isOpen) {
        final res = box.get(key);
        // await box.close();
        return res;
      } else {
        print("box is not open");
        return null;
      }
    }catch (e){
      print(e);
    }
    return null;
  }

  ///update
  @override
  Future<void> putToTable<T>(String tableName, dynamic key, T updated) async {
    final box = await Hive.openBox<T>(tableName);
    if(box.isOpen){
      // if (box.containsKey(key)) {
         await box.put(key, updated);
      // } else {
      //    res= await box.add(updated);
      // }
      await box.close();
    }else{
      print("Cant add box is closed");
    }
  }

  ///delete
  @override
  Future<void> deleteFromTable<T>(String tableName, dynamic key) async {
    final box = Hive.isBoxOpen(tableName) ? (Hive.box<T>(tableName)) : (await Hive.openBox<T>(tableName));
    if(box.isOpen) {
      final res = box.delete(key);
      await box.close();
      return res;
    }
  }

  @override
  Future<dynamic> getKeyOf<T>(String tableName, T val) async {
    final box = Hive.isBoxOpen(tableName) ? (Hive.box<T>(tableName)) : (await Hive.openBox<T>(tableName));
    if(box.isOpen) {
      int index = box.values.toList().indexOf(val);
      dynamic key = box.keyAt(index);
      await box.close();
      return key;
    }
  }

  @override
  Future<dynamic> getKeyWhere<T>(String tableName, bool Function(T a) check) async {
    // late Box<T> box;
    // if (Hive.isBoxOpen(tableName)) {
    //   box = Hive.box(tableName);
    // } else {
    //   box = await Hive.openBox(tableName);
    // }
    final box = Hive.isBoxOpen(tableName)?( Hive.box<T>(tableName)):(await Hive.openBox<T>(tableName));
    if(box.isOpen) {
      int index = box.values.toList().indexWhere((_) => true);
      if (index == -1) return null;
      dynamic key = box.keyAt(index);
      await box.close();
      return key;
    }
  }

  @override
  Future<T?> getFromTableWhere<T>(String tableName, bool Function(T e) rule) async {
    final box = Hive.isBoxOpen(tableName) ? (Hive.box<T>(tableName)) : (await Hive.openBox<T>(tableName));
    if(box.isOpen) {
      final val = box.values.last as UserDB;
      final res = box.values.last;
      // T? res  = box.values.firstWhereOrNull((element) => rule(element));
      await box.close();
      return res;
    }
    return null;

    // return res;
  }

  cleanTable(String s) async {
    await Hive.deleteBoxFromDisk(s);
  }
}
