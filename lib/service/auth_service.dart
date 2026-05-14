import 'package:dio/dio.dart';
import 'package:projct/core/helper/app_validators.dart';
import 'package:projct/model/sign_up_model.dart';

class AuthService {
  String baseurl = "http://127.0.0.1:8000/api/";
  Dio dio = Dio();
  Future<String?> signUp(SignUpModel signUpModel) async {
    try {
      Response response = await dio.post(
        "$baseurl/register",
        data: signUpModel.toMap(),
      );
      if (response.statusCode == 201) {
        return response.statusMessage;
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
