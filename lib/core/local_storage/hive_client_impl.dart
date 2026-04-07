import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/helpers/logger.dart';
import 'package:mansaa_app/core/local_storage/hive_client.dart';

@LazySingleton(as: HiveClient)
class HiveClientImpl implements HiveClient {
  @override
  Future<Box<T>> openBox<T>(String name) async {
    try {
      Logger.debug('Opening Hive box: $name');
      return await Hive.openBox<T>(name);
    } catch (e, stackTrace) {
      Logger.error('Failed to open Hive box: $name', e, stackTrace);
      rethrow;
    }
  }

  @override
  Box<T> getBox<T>(String name) {
    try {
      return Hive.box<T>(name);
    } catch (e, stackTrace) {
      Logger.error(
        'Failed to get Hive box: $name. Ensure it is opened.',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> closeBox(String name) async {
    try {
      Logger.debug('Closing Hive box: $name');
      await Hive.box(name).close();
    } catch (e, stackTrace) {
      Logger.error('Failed to close Hive box: $name', e, stackTrace);
    }
  }

  @override
  Future<void> clearBox(String name) async {
    try {
      Logger.debug('Clearing Hive box: $name');
      await Hive.box(name).clear();
    } catch (e, stackTrace) {
      Logger.error('Failed to clear Hive box: $name', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      Logger.warning('Deleting all Hive boxes data');
      await Hive.deleteFromDisk();
    } catch (e, stackTrace) {
      Logger.error('Failed to delete all Hive data', e, stackTrace);
      rethrow;
    }
  }
}
