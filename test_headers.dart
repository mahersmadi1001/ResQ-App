import 'package:dio/dio.dart';

void main() async {
  try {
    var dio = Dio();
    var response = await dio.get('https://httpbin.org/response-headers?X-New-Token=test1234');
    print('Headers map: ${response.headers.map}');
    print('x-new-token: ${response.headers.value('x-new-token')}');
    print('X-New-Token: ${response.headers.value('X-New-Token')}');
  } catch (e) {
    print('Error: $e');
  }
}
