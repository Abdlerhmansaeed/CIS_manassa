import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/schedule_item_model.dart';
import 'package:mansaa_app/features/academic_schedule/domain/repositories/academic_schedule_repo.dart';

@injectable
class GetAcademicScheduleUseCase {
  final AcademicScheduleRepo _repo;

  GetAcademicScheduleUseCase(this._repo);

  Future<ApiResult<List<ScheduleItemModel>>> call({
    String? studentCode,
    required String studentNationalId,
  }) async {
    return await _repo.getAcademicSchedule(
      studentCode: studentCode,
      studentNationalId: studentNationalId,
    );
  }
}
