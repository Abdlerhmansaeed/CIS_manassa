import 'package:dio/dio.dart';
import 'dart:io';

void main() async {
  final dio = Dio();
  try {
    final response = await dio.post(
      'https://lmscis.com/login/token.php',
      data: {
        'username': 'C2303024',
        'password': 'Vus00893',
        'service': 'moodle_mobile_app',
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.plain,
      ),
    );
    File('response.bin').writeAsBytesSync(response.data.toString().codeUnits);
    print('Done writing response.bin');
  } catch (e) {
    print('Error: ' + e.toString());
  }
}
