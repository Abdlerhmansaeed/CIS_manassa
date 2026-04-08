import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  dio.interceptors.add(LogInterceptor(requestBody: true));
  
  final data = {
    'username': 'C2303024',
    'password': 'Vus00893',
    'service': 'moodle_mobile_app',
  };
  
  final options = Options(
    method: 'POST',
    contentType: 'application/x-www-form-urlencoded',
  ).compose(
    dio.options,
    'https://lmscis.com/login/token.php',
    data: data,
  );
  
  try {
    final response = await dio.fetch(options);
    print("Response data: \${response.data}");
  } catch (e) {
    print("Error: \$e");
  }
}
