import 'package:dio/dio.dart';
import 'package:projct/core/erorr/erorr_handling.dart';
import 'package:projct/core/network/api_constants.dart';
import 'package:projct/service/cache_service.dart';

class LangaugeService {
  final CacheService cacheService;

  LangaugeService({required this.cacheService});
  Future<bool> sendLanguage({required String languagelanCode}) async {
    try {
      Response response = await Dio().patch(
        "${ApiConstants.baseurl}user/language",
        data: {"language": "${languagelanCode}"},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${cacheService.getToken()}',
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      throw Failure.fromDioException(e);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
