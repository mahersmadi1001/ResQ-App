import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:projct/core/erorr/erorr_handling.dart';
import 'package:projct/core/network/api_constants.dart';
import 'package:projct/service/cache_service.dart';

class ReportService {
  Future<Map<String, dynamic>> sendReport({
    required String bodyText,
    required double latitude,
    required double longitude,
    required List<String> newsType,
    required List<File> mediaFiles,
  }) async {
    try {
      String? token = Hive.box(CacheService.boxName).get(CacheService.tokenKey);
      
      List<MultipartFile> multipartMedia = [];
      for (var file in mediaFiles) {
        multipartMedia.add(await MultipartFile.fromFile(file.path));
      }

      FormData formData = FormData.fromMap({
        'body': bodyText,
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      });

      for (int i = 0; i < newsType.length; i++) {
        formData.fields.add(MapEntry('news_type[$i]', newsType[i]));
      }

      for (int i = 0; i < multipartMedia.length; i++) {
        formData.files.add(MapEntry('media[]', multipartMedia[i]));
      }

      Response response = await Dio().post(
        "${ApiConstants.baseurl}reports",
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.data["data"]; 
      }
      return {};
    } on DioException catch (e) {
      throw Failure(
        message: Failure.fromDioException(e),
        statusCode: e.response?.statusCode,
      );
    }
  }
}
