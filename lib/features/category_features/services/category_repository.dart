import 'package:dio/dio.dart';
import 'package:flutter_prokala/features/category_features/services/category_api_service.dart';

import '../model/all_category_model.dart';
import '../model/category_model.dart';

class CategoryRepository {
  final CategoryApiServices _apiServices = CategoryApiServices();

  Future<CategoryModel> fetchCategory() async {
    Response response = await _apiServices.callCategoryApi();
    final CategoryModel categoryModel = CategoryModel.fromJson(response.data);
    return categoryModel;
  }

  Future<AllCategoryModel> callCategoryModel(String id) async {
    Response response = await _apiServices.callAllProduct(id);

    final AllCategoryModel allCategoryModel = AllCategoryModel.fromJson(response.data);
    return allCategoryModel;
  }
}
