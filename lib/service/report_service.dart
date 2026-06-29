import 'package:dio/dio.dart';
import 'package:projct/core/erorr/erorr_handling.dart';
import 'package:projct/core/network/api_constants.dart';
import 'package:projct/model/report_model.dart';

class ReportService {
  Future<String> sendReport({required ReportModel reportModel}) async {
    try {
      String steps = "";
      Response response = await Dio().post(
        "${ApiConstants.baseurl}reports",
        data: reportModel.toJson(),
      );
      if (response.statusCode == 201) {
        steps = await response.data["data"]["advice"]["steps"];
        return steps;
      }
      return steps;
    } on DioException catch (e) {
      throw Failure(
        message: Failure.fromDioException(e),
        statusCode: e.response?.statusCode,
      );
    }
  }
}
