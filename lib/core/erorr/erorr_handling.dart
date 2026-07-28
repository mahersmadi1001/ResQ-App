import 'package:dio/dio.dart';
import 'package:projct/core/localization/app_localizations.dart';

class Failure {
  final String message;
  final int? statusCode;

  Failure({required this.message, this.statusCode});

  static String fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return AppLocalizations.trNoContext("api_errors.connection_timeout");

      case DioExceptionType.sendTimeout:
        return AppLocalizations.trNoContext("api_errors.send_timeout");

      case DioExceptionType.receiveTimeout:
      case DioExceptionType.badCertificate:
        return AppLocalizations.trNoContext("api_errors.bad_certificate");

      case DioExceptionType.badResponse:
        return "${dioException.response?.statusMessage} ${dioException.response?.statusCode} ";

      case DioExceptionType.cancel:
        return AppLocalizations.trNoContext("api_errors.request_cancelled");

      case DioExceptionType.connectionError:
        return AppLocalizations.trNoContext(
          "api_errors.no_internet_connection",
        );

      case DioExceptionType.unknown:
        if (dioException.message?.contains('SocketException') ?? false) {
          return AppLocalizations.trNoContext(
            "api_errors.no_internet_connection",
          );
        }
        return AppLocalizations.trNoContext("api_errors.unexpected_error");
      case DioExceptionType.transformTimeout:
        return AppLocalizations.trNoContext(
          "api_errors.no_internet_connection",
        );
    }
  }

  @override
  String toString() => message;
}
