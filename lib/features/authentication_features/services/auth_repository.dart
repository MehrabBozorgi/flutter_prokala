import 'package:dio/dio.dart';
import 'package:flutter_prokala/features/authentication_features/services/auth_api_service.dart';

class AuthRepository {
  final AuthApiService _apiService = AuthApiService();

  Future<String?> callAuthApi(String phoneNumber) async {
    final Response response = await _apiService.callAuthApi(phoneNumber);

    final String? token = response.data['token'];

    return token;
  }
}
