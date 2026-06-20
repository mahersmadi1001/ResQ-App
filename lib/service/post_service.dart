// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:projct/core/erorr/erorr_handling.dart';

import 'package:projct/core/network/api_constants.dart';
import 'package:projct/model/post_model%20.dart';
import 'package:projct/service/cache_service.dart';

class PostService {
  static int lastPage = 4;
  String postKey = "posts";
  String normalKey = "normal";
  String? newToken;
  CacheService cacheService;
  PostService({required this.cacheService});
  Future<List<PostModel>?> getAllPost({required int page}) async {
    try {
      Response response = await Dio().post(
        "${ApiConstants.baseurl}$postKey/$normalKey?page=$page",
        data: {},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${cacheService.getToken()}',
            "Content-Language": "en",
          },
        ),
      );
      if (response.statusCode == 200) {
        lastPage = response.data["pagination"]["info"]["last_page"] ?? 4;

        newToken =
            (response.headers.value('X-New-Token') ?? cacheService.getToken());
        await cacheService.saveToken(newToken!);

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
}
