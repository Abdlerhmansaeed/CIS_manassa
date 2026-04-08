import 'package:mansaa_app/features/academic_schedule/data/models/schedule_item_model.dart';

abstract interface class AcademicScheduleRemoteDataSource {
  Future<List<ScheduleItemModel>> getAcademicSchedule({
    String? studentCode,
    required String studentNationalId,
  });
}
