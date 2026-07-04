import 'package:dio/dio.dart';

import 'package:projct/core/network/api_constants.dart';
import 'package:projct/service/cache_service.dart';

class RefreshTokenService {
  CacheService cacheService;
  RefreshTokenService({required this.cacheService});
  Future<void> refreshToken() async {
    try {
      Response response = await Dio().get(
        "${ApiConstants.baseurl}/refresh",
        options: Options(
          headers: {'Authorization': 'Bearer ${cacheService.getToken()}'},
        ),
      );
      if (response.statusCode == 200) {
        String newToken = response.data["data"]["new_access_token"];
        if (newToken.isNotEmpty && newToken != null && newToken != "") {
          await cacheService.saveToken(newToken);
        } else {
          return;
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
