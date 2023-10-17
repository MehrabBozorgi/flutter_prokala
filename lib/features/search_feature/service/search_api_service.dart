import 'package:dio/dio.dart';
import 'package:flutter_prokala/const/connection.dart';

class SearchApiServices {
  final Dio _dio = Dio();

  Future<Response> callSearchApi(String search) async {
    final Response response = await _dio.post(
      '$apiUrl/product-search',
      queryParameters: {
        'search': search,
      },
    );
    return response;
  }
}
