import 'package:dio/dio.dart';
import 'package:flutter_prokala/const/connection.dart';
import 'package:flutter_prokala/features/public_features/functions/secure_storage.dart';

class AuthApiService {
  final Dio _dio = Dio();

  /// call authentication api
  Future<Response> callAuthApi(String phoneNumber) async {
    final Response response = await _dio.post(
      '$apiUrl/login',
      queryParameters: {'mobile': phoneNumber},
    );
    return response;
  }

  Future<Response> callLogOut() async {
    final token = await SecureStorageClass().getUserToken();
    final Response response = await _dio.get('$apiUrl/logout/$token');

    return response;
  }
}
