import 'package:dio/dio.dart';

class ApiService {
  final String _baseUrl = 'http://192.168.1.30:8000';
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> post({
    required String endPoint,
    String? jwt,
    required dynamic data,
    bool isFormData = false,
  }) async {
    print("ApiService: post called request: to $_baseUrl$endPoint");
    _dio.options.headers = {
      'Authorization': 'Bearer $jwt',
    };

    try {
      var response = await _dio.post(
        '$_baseUrl$endPoint',
        data: isFormData ? FormData.fromMap(data) : data,
        options: Options(
          headers: isFormData
              ? {
                  'Content-Type': 'multipart/form-data',
                  'Authorization': 'Bearer $jwt',
                }
              : {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $jwt',
                },
        ),
      );
      print("ApiService: response received: $response");
      return response.data;
    } catch (e) {
      print("ApiService: post request failed - Error: $e");
      throw e;
    }
  }

  Future<List<dynamic>> getreq({
    required String endPoint,
    String? jwt,
  }) async {
    try {
      print("ApiService: get called request: $_baseUrl$endPoint");
      _dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      };

      var response = await _dio.get('$_baseUrl$endPoint');
      print("ApiService: response received: $response");

      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<Map<String, dynamic>> get({
    required String endPoint,
    String? jwt,
    dynamic data,
  }) async {
    print("ApiService: post called request: to $_baseUrl$endPoint");
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    };
    var response = await _dio.get(
      '$_baseUrl$endPoint',
      data: data
    );

    print("ApiService:  response received : ${response}");

    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    String? jwt,
    required Map<String, dynamic> data,
  }) async {
    print("ApiService: put called request: to $_baseUrl$endPoint");
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    };
    var response = await _dio.put("$_baseUrl$endPoint", data: data);
    print("ApiService: response received: $response");
    return response.data;
  }

  // Future<Map<String, dynamic>> post({
  //   required String endPoint,
  //   String? jwt,
  //   required dynamic data,
  //   bool isFormData = false,
  // }) async {
  //   print("ApiService: post called request: to $_baseUrl$endPoint");
  //   _dio.options.headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $jwt',
  //   };
  //   var response = await _dio.post(
  //     '$_baseUrl$endPoint',
  //     data: isFormData ? FormData.fromMap(data) : data,
  //   );
  //   print("ApiService:  response received : ${response}");

  //   return response.data;
  // }
}
