import 'package:dio/dio.dart';
import 'package:flutter_prokala/const/connection.dart';
import 'package:flutter_prokala/features/public_features/functions/secure_storage.dart';

class CartApiServices {
  final Dio _dio = Dio();

  /// call add product to cart api
  Future<Response> addToCart(String id) async {
    final token = await SecureStorageClass().getUserToken();
    final Response response = await _dio.get('$apiUrl/add-to-cart/$id/$token');
    return response;
  }

  /// call show cart api
  Future<Response> callShowCart() async {
    final token = await SecureStorageClass().getUserToken();
    final Response response = await _dio.get('$apiUrl/show-cart/$token');
    return response;
  }

  ///  change count of products in list
  Future<Response> changeCartCount({
    required String pId,
    required String cartId,
    required String newCount,
  }) async {
    final token = await SecureStorageClass().getUserToken();

    final Response response =
        await _dio.get('$apiUrl/cart/change-count/$pId/$cartId/$newCount/$token');

    return response;
  }

  /// delete single item with api
  Future<Response> deleteItem(String cartId) async {
    final Response response = await _dio.get('$apiUrl/cart/delete-one/$cartId');
    return response;
  }


  /// delete all items in cart
  Future<Response> deleteAllItems() async {
    final token = await SecureStorageClass().getUserToken();
    final Response response = await _dio.get('$apiUrl/cart/delete-all/$token');
    return response;
  }
}
