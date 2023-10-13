import 'package:dio/dio.dart';
import 'package:flutter_prokala/features/product_feature/model/product_model.dart';
import 'package:flutter_prokala/features/product_feature/services/product_api_services.dart';

class ProductRepository {
  ProductApiServices _apiServices = ProductApiServices();

  Future<ProductModel> callDetailProduct(String id) async {
    final Response response = await _apiServices.callDetailProductApi(id);

    ProductModel productModel = ProductModel.fromJson(response.data);
    return productModel;
  }
}
