import 'package:dio/dio.dart';

class ApiService {
  final String _baseUrl = 'http://192.168.1.7:8000';
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> post({
    required String endPoint,
    String? jwt,
    required dynamic data,
  }) async {
    print("ApiService: post called request: to $_baseUrl$endPoint");
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    };
    var response = await _dio.post('$_baseUrl$endPoint', data: data);
    print("ApiService:  response received : ${response}");

    return response.data;
  }

  Future<Map<String, dynamic>> get({
    required String endPoint,
    String? jwt,
  }) async {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    };
    var response = await _dio.get(
      '$_baseUrl$endPoint',
    );
    return response.data;
  }
}
