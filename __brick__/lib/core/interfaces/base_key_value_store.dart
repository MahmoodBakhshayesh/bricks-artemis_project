/// An abstract interface for a simple key-value storage system.
///
/// This class defines a contract for storing, retrieving, and removing data
/// using string keys. It's designed to be implemented by concrete storage
/// solutions like SharedPreferences or Hive.
abstract class BaseKeyValueStore {
  /// Retrieves a value of type [T] from storage for the given [key].
  ///
  /// Returns the value if it exists, otherwise returns null.
  String? get(String key);

  /// Writes a [value] of type [T] to storage under the specified [key].
  ///
  /// Returns a [Future<bool>] that completes with true if the write was
  /// successful, and false otherwise.
  Future<bool> write(String key, String value);

  /// Removes the value associated with the given [key] from storage.
  ///
  /// Returns a [Future<bool>] that completes with true if the removal was
  /// successful, and false otherwise.
  Future<bool> remove(String key);

  Future<bool> clear();
}
