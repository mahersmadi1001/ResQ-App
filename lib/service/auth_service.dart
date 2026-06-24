import 'package:dio/dio.dart';
import 'package:projct/core/erorr/erorr_handling.dart';
import 'package:projct/core/network/api_constants.dart';

import 'package:projct/model/sign_up_model.dart';
import 'package:projct/model/login_model.dart';
import 'package:projct/model/user_model.dart';
import 'package:projct/service/cache_service.dart';
import 'package:projct/core/config/di.dart';

class AuthService {
  String baseurl = ApiConstants.baseurl;
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
        "${baseurl}otp/send",
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

  Future<String> login(LoginModel loginModel) async {
    try {
      Response response = await dio.post(
        "${baseurl}login",
        data: loginModel.toMap(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final token = data['token'];
        final userJson = data['user'];

        await di<CacheService>().saveToken(token);
        await di<CacheService>().saveUser(UserModel.fromJson(userJson));
        return "تم تسجيل الدخول بنجاح";
      }

      throw Failure(
        message: "فشل تسجيل الدخول، تأكد من البيانات",
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

  Future<void> logout() async {
    try {
      String? token = di<CacheService>().getToken();
      if (token == null) throw Failure(message: "غير مسجل الدخول");

      Response response = await dio.delete(
        "${baseurl}logout",
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        await di<CacheService>().deleteToken();
        await di<CacheService>().deleteUser();
        return;
      }

      throw Failure(
        message: "فشل تسجيل الخروج",
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
        "${baseurl}otp/verify",
        data: {"email": email, "otp": otp},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final token = data['token'];
        final userJson = data['user'];

        await di<CacheService>().saveToken(token);
        await di<CacheService>().saveUser(UserModel.fromJson(userJson));
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
