import '../../category_features/model/all_category_model.dart';

class SearchModel {
  int? status;

  List<SearchProduct>? searchProduct;

  SearchModel.fromJson(dynamic json) {
    status = json['status'];

    if (json['products'] != null) {
      searchProduct = [];
      json['products'].forEach((v) {
        searchProduct?.add(SearchProduct.fromJson(v));
      });
    }
  }
}

class SearchProduct extends Product {
  SearchProduct.fromJson(super.json) : super.fromJson();
}
