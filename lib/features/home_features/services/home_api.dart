import 'package:dio/dio.dart';

import '../../../const/connection.dart';

class HomeApiServices {
  final Dio _dio = Dio();

  Future<Response> callHomeApi() async {

    _dio.options.connectTimeout=const Duration(seconds: 25);
    _dio.options.receiveTimeout=const Duration(seconds: 25);
    _dio.options.sendTimeout=const Duration(seconds: 25);

    final Response response = await _dio.get('$apiUrl/index');

    return response;
  }
}
