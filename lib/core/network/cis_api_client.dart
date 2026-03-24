import 'package:dio/dio.dart';
import 'package:mansaa_app/core/network/endpoints/app_endpoints.dart';
import 'package:retrofit/retrofit.dart';

part 'cis_api_client.g.dart';

@RestApi()
abstract class CisApiClient {
  factory CisApiClient(Dio dio, {String? baseUrl}) = _CisApiClient;

  @GET(AppEndPoints.credentialsEndPoint)
  @DioResponseType(ResponseType.plain)
  Future<String> getCredentials({
    @Query('student_id') required String studentId,
    @Query('national_number') required String nationalNumber,
  });

  @GET(AppEndPoints.getAcademicScheduleEndPoint)
  @DioResponseType(ResponseType.plain)
  Future<String> getAcademicSchedule({
    @Query('student_id') String studentId = "",
    @Query('national_number') String nationalNumber= "",
  });
}
