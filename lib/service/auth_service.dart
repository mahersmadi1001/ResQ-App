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
        return "Your information has been successfully recorded";
      }

      throw Failure(
        message: "Your request hasn't been recorded",
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      throw Failure(
        message: Failure.fromDioException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw Failure(
        message: "An unexpected error occurred: ${e.toString()}",
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
        message: "Failed to send the verification code",
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      throw Failure(
        message: Failure.fromDioException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw Failure(
        message: "An unexpected error occurred: ${e.toString()}",
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
        return "Logged in successfully";
      }

      throw Failure(
        message: "Login failed, check your details",
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      throw Failure(
        message: Failure.fromDioException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw Failure(
        message: "An unexpected error occurred: ${e.toString()}",
        statusCode: null,
      );
    }
  }

  Future<void> logout() async {
    try {
      String? token = di<CacheService>().getToken();
      if (token == null) throw Failure(message: "Not logged in");

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

      throw Failure(message: "Logout failed", statusCode: response.statusCode);
    } on DioException catch (e) {
      throw Failure(
        message: Failure.fromDioException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw Failure(
        message: "An unexpected error occurred: ${e.toString()}",
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
        message: "Failed to verify the code",
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      throw Failure(
        message: Failure.fromDioException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw Failure(
        message: "An unexpected error occurred: ${e.toString()}",
        statusCode: null,
      );
    }
  }
}
