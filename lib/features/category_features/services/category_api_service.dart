import 'package:dio/dio.dart';
import 'package:flutter_prokala/const/connection.dart';

class CategoryApiServices {
  final Dio _dio = Dio();

  /// fetch category api
  Future<Response> callCategoryApi() async {
    _dio.options.connectTimeout = const Duration(seconds: 25);
    _dio.options.receiveTimeout = const Duration(seconds: 25);
    _dio.options.sendTimeout = const Duration(seconds: 25);

    final Response response = await _dio.get('$apiUrl/get-menu-category');

    return response;
  }

  Future<Response> callAllProduct(String id) async {
    final Response response = await _dio.get('$apiUrl/product-category/$id');

    return response;
  }
}
