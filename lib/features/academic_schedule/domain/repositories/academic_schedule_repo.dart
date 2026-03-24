import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/schedule_item_model.dart';

abstract interface class AcademicScheduleRepo {
  Future<ApiResult<List<ScheduleItemModel>>> getAcademicSchedule({
    String? studentCode,
    required String studentNationalId
  });
}
