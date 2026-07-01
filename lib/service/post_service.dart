import 'package:dio/dio.dart';
import 'package:projct/core/erorr/erorr_handling.dart';
import 'package:projct/core/network/api_constants.dart';
import 'package:projct/model/post_admin_model.dart';
import 'package:projct/model/post_model%20.dart';
import 'package:projct/service/cache_service.dart';

class PostService {
  static int lastPage = 4;
  static int lastPageAdmin = 3;
  String postKey = "posts";
  String normalKey = "normal";
  String adminKey = "admin";

  CacheService cacheService;
  PostService({required this.cacheService});
  Future<List<PostModel>?> getAllPost({
    required int page,
    List<String>? filterParamtr,
  }) async {
    try {
      Response response = await Dio().post(
        "${ApiConstants.baseurl}$postKey/$normalKey?page=$page",
        data: {"cities": filterParamtr ?? [], "governorates": []},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${cacheService.getToken()}',
            "Accept-Language": "en",
          },
        ),
      );
      if (response.statusCode == 200) {
        lastPage = response.data["pagination"]["info"]["last_page"] ?? 4;

        // String? newHeaderToken =
        //     response.headers.value('x-new-token') ??
        //     response.headers.value('X-New-Token');
        // if (newHeaderToken != null && newHeaderToken.isNotEmpty) {
        //   await cacheService.saveToken(newHeaderToken);
        //   print(newHeaderToken);
        // }

        return List.generate(
          response.data["data"]["posts"].length,
          (index) => PostModel.fromJson(response.data["data"]["posts"][index]),
        );
      } else {
        return null;
      }
    } on DioException catch (e) {
      throw Failure(
        message: Failure.fromDioException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
  //=====================================================================

  Future<List<PostAdminModel>?> getAllPostAdmin({
    required int page,
    List<String>? filterParamtr,
  }) async {
    try {
      Response response = await Dio().get(
        "${ApiConstants.baseurl}$postKey/$adminKey?page=$page",
        data: {"cities": filterParamtr ?? [], "governorates": []},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${cacheService.getToken()}',
            "Accept-Language": "en",
          },
        ),
      );
      if (response.statusCode == 200) {
        lastPageAdmin = response.data["pagination"]["info"]["last_page"] ?? 3;

        return List.generate(
          response.data["data"]["posts"].length,
          (index) =>
              PostAdminModel.fromJson(response.data["data"]["posts"][index]),
        );
      } else {
        return null;
      }
    } on DioException catch (e) {
      throw Failure(
        message: Failure.fromDioException(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
