import 'package:dio/dio.dart';
import 'package:flutter_prokala/const/connection.dart';
import 'package:flutter_prokala/features/public_features/functions/secure_storage.dart';

class ProductApiServices {
  final Dio _dio = Dio();

  /// call detail product by product id
  Future<Response> callDetailProductApi(String id) async {
    final token = await SecureStorageClass().getUserToken()??false;
    print('-----------------------------');
    print(token);

    final Response response = await _dio.get('$apiUrl/product/$id/$token');

    return response;
  }
}
