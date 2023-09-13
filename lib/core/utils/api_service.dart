import 'package:dio/dio.dart';

class ApiService{
  final Dio _dio;
  final String _baseUrl = 'https://www.googleapis.com/books/v1/';
  ApiService(this._dio);

Future<Map<String,dynamic>> getBooks({required String endpoint}) async {
    final response = await _dio.get(_baseUrl+endpoint);
    return response.data;
  }

}