abstract class LocalDataSourceInterface {
  ///create
  Future<int> addToTable<T>(String tableName,T data);

  ///read
  Future<T?> getFromTable<T>(String tableName,dynamic key);


  ///update
  Future<void> putToTable<T>(String tableName,dynamic key,T updated);


  ///delete
  Future<void> deleteFromTable<T>(String tableName,dynamic key);

  ///query
  Future<T?> getFromTableWhere<T>(String tableName,bool Function(T e) rule);

  Future<dynamic> getKeyOf<T>(String tableName,T val);

  Future<dynamic> getKeyWhere<T>(String tableName,bool Function(T a) check);

}

extension FirstWhereExt<T> on Iterable<T> {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
