import 'package:dio/dio.dart';
import 'package:flutter_prokala/features/comment_features/model/comment_model.dart';
import 'package:flutter_prokala/features/comment_features/services/comment_api_services.dart';

class CommentRepository {
  final CommentApiServices _apiServices = CommentApiServices();

  Future<CommentModel> callShowComment(String productId) async {
    final Response response = await _apiServices.callShowComment(productId);

    final CommentModel commentModel = CommentModel.fromJson(response.data);
    return commentModel;
  }

  Future<String> addProduct(String comment, String pid) async {
    final Response response = await _apiServices.addCommentApi(comment, pid);

    return response.data['msg'];
  }
}
