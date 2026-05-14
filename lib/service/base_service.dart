import 'package:dio/dio.dart';

abstract class BaseService<T> {
  Dio dio = Dio();
  String baseUrl = "http://127.0.0.1:8000/api/";
  late Response response;
  Future<List<T>>? getAll();
  Future<bool> delete();
  Future<bool> send({required T item});
  Future<T> getById({required int id});
  Future<bool> update({required T item});
}
