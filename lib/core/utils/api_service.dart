import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  final Dio _dio;
  final _baseUrl = 'https://www.googleapis.com/books/v1/';
  ApiService(this._dio);
  Future<Map<String, dynamic>> getRequest(
      {required String endPoint, @required String? token}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    Response response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(
        headers: headers,
        
        sendTimeout: const Duration(seconds: 7),
        receiveTimeout: const Duration(seconds: 7),
      ),
    );
    return response.data;
  }
}
