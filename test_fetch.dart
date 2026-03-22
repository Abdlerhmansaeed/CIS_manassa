import 'package:dio/dio.dart';

void main() async {
  final _dio = Dio();
  _dio.interceptors.add(LogInterceptor(requestBody: true));
  
  final _data = {
    'username': 'C2303024',
    'password': 'Vus00893',
    'service': 'moodle_mobile_app',
  };
  
  final _options = Options(
    method: 'POST',
    contentType: 'application/x-www-form-urlencoded',
  ).compose(
    _dio.options,
    'https://lmscis.com/login/token.php',
    data: _data,
  );
  
  try {
    final response = await _dio.fetch(_options);
    print("Response data: \${response.data}");
  } catch (e) {
    print("Error: \$e");
  }
}
