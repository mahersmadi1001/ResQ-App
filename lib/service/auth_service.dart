import 'package:dio/dio.dart';
import 'package:projct/core/erorr/erorr_handling.dart';

import 'package:projct/model/sign_up_model.dart';

class AuthService {
  String baseurl = "http://127.0.0.1:8000/api/";
  Dio dio = Dio();

  Future<String> signUp(SignUpModel signUpModel) async {
    try {
      Response response = await dio.post(
        "${baseurl}register",
        data: signUpModel.toMap(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 201) {
        return "تم تسجيل معلوماتك بنجاح";
      }

      throw Failure(
        message: "لم يتم تسجيل طلبك",
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      throw Failure(
        message: Failure.fromDioException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw Failure(
        message: "حدث خطأ غير متوقع: ${e.toString()}",
        statusCode: null,
      );
    }
  }

  Future<bool> sendOtp({required String email}) async {
    try {
      Response response = await dio.post(
        "${baseurl}sendotp",
        data: {"email": email},
      );

      if (response.statusCode == 200) {
        return true;
      }

      throw Failure(
        message: "فشل في إرسال رمز التحقق",
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      throw Failure(
        message: Failure.fromDioException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw Failure(
        message: "حدث خطأ غير متوقع: ${e.toString()}",
        statusCode: null,
      );
    }
  }

  Future<bool> verifyOtp({required String email, required String otp}) async {
    try {
      Response response = await dio.post(
        "${baseurl}verifyotp",
        data: {
          "email": email,
          "otp": otp,
        },
      );

      if (response.statusCode == 200) {
        return true;
      }

      throw Failure(
        message: "فشل في التحقق من الرمز",
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      throw Failure(
        message: Failure.fromDioException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw Failure(
        message: "حدث خطأ غير متوقع: ${e.toString()}",
        statusCode: null,
      );
    }
  }
}
