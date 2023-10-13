import 'package:dio/dio.dart';
import 'package:flutter_prokala/const/connection.dart';
import 'package:flutter_prokala/features/public_features/functions/secure_storage.dart';

class FavoriteApiServices {
  final Dio _dio = Dio();

  /// call add product to favorite list
  Future<Response> addToFavoriteApi(String id) async {
    final token = await SecureStorageClass().getUserToken();
    final Response response = await _dio.get('$apiUrl/add-favorite/$id/$token');
    return response;
  }
}
