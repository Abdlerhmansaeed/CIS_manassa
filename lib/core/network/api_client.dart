import 'package:dio/dio.dart';
import 'package:mansaa_app/core/network/endpoints/app_endpoints.dart';
import 'package:mansaa_app/features/auth/data/models/login_response/login_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;


  @POST(AppEndPoints.loginStudentEndPoint)
  @FormUrlEncoded()
  Future<LoginResponse> login(
    @Field("username") String userCode,
    @Field("password") String password,
    {
      @Field("service") String service = "moodle_mobile_app",
    } 
  );
}
