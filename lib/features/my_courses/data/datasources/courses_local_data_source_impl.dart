import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/constants/app_keys.dart';
import 'package:mansaa_app/core/helpers/logger.dart';
import 'package:mansaa_app/core/local_storage/local_storage_client.dart';
import 'package:mansaa_app/features/my_courses/data/datasources/courses_local_data_source.dart';
import 'package:mansaa_app/features/my_courses/data/models/student_courese_response/student_courese_response.dart';

@Injectable(as: CoursesLocalDataSource)
class CoursesLocalDataSourceImpl implements CoursesLocalDataSource {
  final LocalStorageClient _storageClient;

  /// Cache time-to-live: 30 minutes.
  static const _cacheTtl = Duration(minutes: 30);

  CoursesLocalDataSourceImpl(this._storageClient);

  @override
  Future<void> cacheCourses(List<StudentCourseResponse> courses) async {
    final jsonList = courses.map((c) => c.toJson()).toList();
    final encoded = jsonEncode(jsonList);

    await Future.wait([
      _storageClient.saveData(
        key: AppKeys.cachedCourses,
        value: encoded,
      ),
      _storageClient.saveData(
        key: AppKeys.coursesCachedAt,
        value: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
    ]);

    Logger.debug('Cached ${courses.length} courses');
  }

  @override
  Future<List<StudentCourseResponse>?> getCachedCourses() async {
    final raw = await _storageClient.getData(key: AppKeys.cachedCourses);
    if (raw == null || raw.isEmpty) return null;

    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map((e) =>
              StudentCourseResponse.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e, stackTrace) {
      Logger.error('Failed to decode cached courses', e, stackTrace);
      return null;
    }
  }

  @override
  Future<bool> isCacheValid() async {
    final cachedAt =
        await _storageClient.getData(key: AppKeys.coursesCachedAt);
    if (cachedAt == null) return false;

    final timestamp =
        DateTime.fromMillisecondsSinceEpoch(int.parse(cachedAt));
    return DateTime.now().difference(timestamp) < _cacheTtl;
  }
}
