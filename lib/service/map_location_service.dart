import 'package:dio/dio.dart';
import 'package:projct/core/erorr/erorr_handling.dart';
import 'package:projct/core/network/api_constants.dart';
import 'package:projct/model/location_point_model.dart';
import 'package:projct/service/cache_service.dart';

class MapLocationService {
  CacheService cacheService;
  MapLocationService({required this.cacheService});

  Future<List<LocationPointModel>> fetchLocations() async {
    try {
      final response = await Dio().get(
        '${ApiConstants.baseurl}posts/location',
        options: Options(
          headers: {'Authorization': 'Bearer ${cacheService.getToken()}'},
        ),
      );

      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((json) => LocationPointModel.fromJson(json)).toList();
      } else {
        throw Failure(message: 'Failed to load locations');
      }
    } on DioException catch (e) {
      throw Failure(message: Failure.fromDioException(e));
    }
  }
}
