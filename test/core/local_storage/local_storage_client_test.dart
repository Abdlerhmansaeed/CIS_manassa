import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mansaa_app/core/local_storage/local_storage_client_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late MockFlutterSecureStorage mockSecureStorage;
  late LocalStorageClientImpl localStorageClient;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    mockSecureStorage = MockFlutterSecureStorage();
    localStorageClient = LocalStorageClientImpl(
      mockSharedPreferences,
      mockSecureStorage,
    );
  });

  group('LocalStorageClientImpl - Public Storage', () {
    const key = 'test_key';
    const value = 'test_value';

    test('saveData should call setString on SharedPreferences', () async {
      when(() => mockSharedPreferences.setString(key, value)).thenAnswer((_) async => true);

      await localStorageClient.saveData(key: key, value: value);

      verify(() => mockSharedPreferences.setString(key, value)).called(1);
    });

    test('getData should return value from SharedPreferences', () async {
      when(() => mockSharedPreferences.getString(key)).thenReturn(value);

      final result = await localStorageClient.getData(key: key);

      expect(result, value);
      verify(() => mockSharedPreferences.getString(key)).called(1);
    });

    test('deleteData should call remove on SharedPreferences', () async {
      when(() => mockSharedPreferences.remove(key)).thenAnswer((_) async => true);

      await localStorageClient.deleteData(key: key);

      verify(() => mockSharedPreferences.remove(key)).called(1);
    });
  });

  group('LocalStorageClientImpl - Secure Storage', () {
    const key = 'secure_key';
    const value = 'secure_value';

    test('saveSecureData should call write on FlutterSecureStorage', () async {
      when(() => mockSecureStorage.write(key: key, value: value))
          .thenAnswer((_) async => {});

      await localStorageClient.saveSecureData(key: key, value: value);

      verify(() => mockSecureStorage.write(key: key, value: value)).called(1);
    });

    test('getSecureData should return value from FlutterSecureStorage', () async {
      when(() => mockSecureStorage.read(key: key)).thenAnswer((_) async => value);

      final result = await localStorageClient.getSecureData(key: key);

      expect(result, value);
      verify(() => mockSecureStorage.read(key: key)).called(1);
    });

    test('deleteSecureData should call delete on FlutterSecureStorage', () async {
      when(() => mockSecureStorage.delete(key: key)).thenAnswer((_) async => {});

      await localStorageClient.deleteSecureData(key: key);

      verify(() => mockSecureStorage.delete(key: key)).called(1);
    });
  });

  test('clearAll should clear both storages', () async {
    when(() => mockSharedPreferences.clear()).thenAnswer((_) async => true);
    when(() => mockSecureStorage.deleteAll()).thenAnswer((_) async => {});

    await localStorageClient.clearAll();

    verify(() => mockSharedPreferences.clear()).called(1);
    verify(() => mockSecureStorage.deleteAll()).called(1);
  });
}
