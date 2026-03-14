import 'user/user_entity.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'generated/objectbox.g.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "obx-example"),macosApplicationGroup: "ODCS");
    return ObjectBox._create(store);
  }
}

Future<void> seedDatabase(Store store) async {
  final metaBox = store.box<UserEntity>();
  final meta = metaBox.get(1);

  if (meta != null) {
    return;
  }
  UserEntity admin = UserEntity();
  admin.username = "admin";
  admin.password = "admin";

  metaBox.put(admin);
}