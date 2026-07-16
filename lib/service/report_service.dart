import 'dart:io';
import 'package:dio/dio.dart';
import 'package:projct/core/config/di.dart';
import 'package:projct/core/erorr/erorr_handling.dart';
import 'package:projct/core/network/api_constants.dart';
import 'package:projct/model/report_model.dart';
import 'package:projct/service/cache_service.dart';

class ReportService {
  Future<Map<String, dynamic>> sendReport({
    required ReportModel reportModel,
  }) async {
    try {
      final String? token = di<CacheService>().getToken();

      final formData = FormData();
      formData.fields.add(MapEntry('latitude', reportModel.latitude));
      formData.fields.add(MapEntry('longitude', reportModel.longitude));

      if (reportModel.body.isNotEmpty) {
        formData.fields.add(MapEntry('body', reportModel.body));
      }

      if (reportModel.newsType.isNotEmpty) {
        for (final type in reportModel.newsType) {
          String normalizedType = type.trim();
          if (normalizedType.contains(' ')) {
            final words = normalizedType.split(' ');
            final firstWord = words.first;
            final capitalizedFirst = firstWord.isNotEmpty
                ? '${firstWord[0].toUpperCase()}${firstWord.substring(1).toLowerCase()}'
                : '';
            final rest = words.skip(1).join(' ').toLowerCase();
            normalizedType = '$capitalizedFirst $rest';
          } else {
            normalizedType = normalizedType.toLowerCase();
          }

          formData.fields.add(MapEntry('news_type', normalizedType));
          formData.fields.add(MapEntry('news_type[]', normalizedType));
        }
      }

      for (final mediaItem in reportModel.media) {
        if (mediaItem is File) {
          final filename = mediaItem.path.split(RegExp(r'[/\\]')).last;
          formData.files.add(
            MapEntry(
              'media',
              await MultipartFile.fromFile(mediaItem.path, filename: filename),
            ),
          );
        }
      }

      final response = await Dio().post(
        '${ApiConstants.baseurl}reports',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Accept-Language': 'ar',
            'Content-Language': 'ar',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.data['data'] as Map<String, dynamic>;
      }
      return {};
    } on DioException catch (e) {
      String errorMessage = Failure.fromDioException(e);
      if (e.response?.data != null) {
        try {
          final data = e.response?.data;
          if (data is Map && data.containsKey('message')) {
            errorMessage += '\n${data['message']}';
          }
          if (data is Map && data.containsKey('errors')) {
            final errors = data['errors'] as Map;
            errors.forEach((key, value) {
              errorMessage += '\n$key: $value';
            });
          }
        } catch (_) {}
      }
      throw Failure(
        message: errorMessage,
        statusCode: e.response?.statusCode,
      );
    }
  }
}

