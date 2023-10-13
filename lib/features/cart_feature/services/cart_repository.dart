import 'package:dio/dio.dart';

import '../model/cart_model.dart';
import 'cart_api_services.dart';

class CartRepository {
  final CartApiServices _apiServices = CartApiServices();

  Future<void> addToCart(String id) async {
    await _apiServices.addToCart(id);
  }

  Future<CartModel> callShowCart() async {
    final Response response = await _apiServices.callShowCart();

    CartModel cartModel = CartModel.fromJson(response.data);

    return cartModel;
  }

  Future<String> changeCartCount({
    required String pId,
    required String cartId,
    required String newCount,
  }) async {
    final Response response =
        await _apiServices.changeCartCount(pId: pId, cartId: cartId, newCount: newCount);
    return response.data['total_cart'].toString();
  }

  Future<void> deleteItem(String cartId) async {
    await _apiServices.deleteItem(cartId);
  }

  Future<void>deleteAllItems()async{
    await _apiServices.deleteAllItems();
  }

}
