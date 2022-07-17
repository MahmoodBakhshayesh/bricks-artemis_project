// import 'dart:io';
//
// import 'package:path_provider/path_provider.dart';
//
// import 'objectbox.g.dart'; // created by `flutter pub run build_runner build`
//
// class ObjectBox {
//   /// The Store of this app.
//   late final Store store;
//
//   ObjectBox._create(this.store) {
//     // Add any additional setup code, e.g. build queries.
//   }
//
//   /// Create an instance of ObjectBox to use throughout the app.
//   static Future<ObjectBox> create() async {
//     // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
//     // final store = await openStore();
//     Directory tempDir = await getTemporaryDirectory();
//     // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
//     // final store = await openStore(macosApplicationGroup: 'com.abomis.dcs',directory: tempDir.path);
//     final store = Store(getObjectBoxModel(), directory: tempDir.path + '/objectbox',macosApplicationGroup: '5PS562MJDF.dcs');
//     return ObjectBox._create(store);
//     return ObjectBox._create(store);
//   }
// }

class ObjectBox {
  static Future<ObjectBox> create() async {
    // Directory tempDir = await getTemporaryDirectory();
    // final store = Store(getObjectBoxModel(), directory: tempDir.path + '/objectbox',macosApplicationGroup: '5PS562MJDF.dcs');
    // return ObjectBox._create(store);
    return ObjectBox();
  }
}