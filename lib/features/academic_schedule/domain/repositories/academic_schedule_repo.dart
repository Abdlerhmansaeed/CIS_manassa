import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/schedule_item_model.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/student_credentials_model.dart';

abstract interface class AcademicScheduleRepo {
  Future<ApiResult<List<ScheduleItemModel>>> getAcademicSchedule({
    String? studentCode,
    required String studentNationalId,
    bool forceRefresh = false,
  });

  Future<void> saveCredentials(StudentCredentialsModel credentials);
  Future<StudentCredentialsModel?> getCredentials();
}
