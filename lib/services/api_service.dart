import 'dart:convert';
// import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../models/user_model.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    // Base URL
    _dio.options.baseUrl = 'https://jsonplaceholder.typicode.com';

    // Interceptor untuk logging
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<List<User>> fetchUsers() async {
    try {
      final response = await _dio.get('/users');
      return (response.data as List)
          .map((json) => User.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception('Failed to load users: ${e.message}');
    }
  }
}


// class ApiService {
//   static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
//
//   Future<List<User>> fetchUsers() async {
//     final response = await http.get(Uri.parse('$_baseUrl/users'));
//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       return data.map((json) => User.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load users');
//     }
//   }
// }