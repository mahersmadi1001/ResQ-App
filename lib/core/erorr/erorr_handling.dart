import 'package:dio/dio.dart';

class Failure {
  final String message;
  final int? statusCode;

  Failure({required this.message, this.statusCode});

  static String fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return "انتهت مهلة الاتصال بخادم الـ API";

      case DioExceptionType.sendTimeout:
        return "انتهت مهلة إرسال البيانات إلى السيرفر";

      case DioExceptionType.receiveTimeout:
      case DioExceptionType.badCertificate:
        return "شهادة الأمان (Certificate) غير صالحة";

      case DioExceptionType.badResponse:
        return "${dioException.response?.statusMessage
        } ${dioException.response?.statusCode} ";

      case DioExceptionType.cancel:
        return "تم إلغاء الطلب المرسل إلى السيرفر";

      case DioExceptionType.connectionError:
        return "لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة";

      case DioExceptionType.unknown:
        if (dioException.message?.contains('SocketException') ?? false) {
          return "لا يوجد اتصال بالإنترنت";
        }
        return "حدث خطأ غير متوقع، يرجى المحاولة لاحقاً";
    }
  }

  @override
  String toString() => message;
}
