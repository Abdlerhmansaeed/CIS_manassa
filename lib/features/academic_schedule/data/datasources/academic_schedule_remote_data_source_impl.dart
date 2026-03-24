import 'package:mansaa_app/core/network/cis_api_client.dart';
import 'package:mansaa_app/features/academic_schedule/data/datasources/academic_schedule_remote_data_source.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/schedule_item_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AcademicScheduleRemoteDataSource)
class AcademicScheduleRemoteDataSourceImpl
    implements AcademicScheduleRemoteDataSource {
  final CisApiClient _cisApiClient;

  AcademicScheduleRemoteDataSourceImpl(this._cisApiClient);

  @override
  Future<List<ScheduleItemModel>> getAcademicSchedule({
    String? studentCode,
    required String studentNationalId,
  }) async {
    final html = await _cisApiClient.getAcademicSchedule(
      nationalNumber: studentNationalId,
      studentId: studentCode ?? '',
    );
    return ScheduleItemModel.fromHtml(html);
  }
}
