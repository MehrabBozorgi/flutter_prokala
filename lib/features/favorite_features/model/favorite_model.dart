class FavoriteModel {
  int? status;
  List<Favorite>? favorites;

  FavoriteModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['favorites'] != null) {
      favorites = [];
      json['favorites'].forEach((v) {
        favorites?.add(Favorite.fromJson(v));
      });
    }
  }

  FavoriteModel({
    this.status,
    this.favorites,
  });
}

class Favorite {
  int? id;
  String? productTitle;
  String? productPrice;
  String? productImage;
  String? productId;

  Favorite({
    this.id,
    this.productTitle,
    this.productPrice,
    this.productImage,
    this.productId,
  });

  Favorite.fromJson(dynamic json) {
    id = json['id'];
    productTitle = json['product_title'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
    productId = json['product_id'];
  }
}
