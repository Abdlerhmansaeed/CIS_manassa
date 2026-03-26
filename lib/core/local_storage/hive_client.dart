import 'package:hive_ce/hive.dart';

abstract interface class HiveClient {
  /// Opens a box with the given [name].
  Future<Box<T>> openBox<T>(String name);

  /// Gets a box with the given [name].
  /// The box must be opened first.
  Box<T> getBox<T>(String name);

  /// Closes a box with the given [name].
  Future<void> closeBox(String name);

  /// Clears all data from a box with the given [name].
  Future<void> clearBox(String name);

  /// Deletes all data from all boxes.
  Future<void> clearAll();
}
