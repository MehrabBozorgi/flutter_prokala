import 'package:dio/dio.dart';
import 'package:flutter_prokala/const/connection.dart';
import 'package:flutter_prokala/features/public_features/functions/secure_storage.dart';

class CommentApiServices {
  final Dio _dio = Dio();

  /// call get all comment by product id
  Future<Response> callShowComment(String productId) async {
    final Response response = await _dio.get('$apiUrl/comment/product/$productId');
    return response;
  }

  Future<Response> addCommentApi(String comment, String pid) async {
    final token = await SecureStorageClass().getUserToken();
    final Response response = await _dio.post(
      '$apiUrl/save-comment',
      queryParameters: {
        'token': token,
        'comment': comment,
        'type': 'product',
        'pid': pid,
      },
    );
    return response;
  }
}
