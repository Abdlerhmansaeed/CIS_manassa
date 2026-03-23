import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/session/user_session.dart';

@singleton
class AuthInterceptor extends Interceptor {
  final UserSession _userSession;

  AuthInterceptor(this._userSession);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _userSession.getToken();

    if (token != null) {
      options.queryParameters.addAll({
        'wstoken': token,
        'moodlewsrestformat': 'json',
      });
    }

    super.onRequest(options, handler);
  }
}
