import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/error_handling/models/server_error_response.dart';

/// Interceptor to handle Moodle's "200-OK-with-error-body" behavior.
/// 
/// If the response contains an `errorcode` or `error` key, it elevates the
/// response to a [DioExceptionType.badResponse] so the error layer can process it.
@singleton
class MoodleErrorInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Check if the body represents a Moodle error response
    if (ServerErrorResponse.isErrorResponse(response.data)) {
      // Throwing a DioException here forces Dio to treat this successful
      // HTTP response as a failure, triggering our safeApiCall catch blocks.
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Moodle logic error detected in 200 OK response',
        ),
        true, // call following error interceptors
      );
      return;
    }
    
    super.onResponse(response, handler);
  }
}
