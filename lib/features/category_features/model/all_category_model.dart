class AllCategoryModel {
  int? status;

  List<Product>? product;

  AllCategoryModel.fromJson(dynamic json) {
    status = json['status'];

    if (json['products'] != null) {
      product = [];
      json['products'].forEach((v) {
        product?.add(Product.fromJson(v));
      });
    }
  }
}

class Product {
  int? productId;
  String? productImage;
  String? productTitle;
  String? productPrice;

  Product({
    required this.productId,
    required this.productImage,
    required this.productTitle,
    required this.productPrice,
  });

  Product.fromJson(dynamic json) {
    productId = json['product_id'];
    productImage = json['product_image'];
    productTitle = json['product_title'];
    productPrice = json['product_price'];
  }
}
