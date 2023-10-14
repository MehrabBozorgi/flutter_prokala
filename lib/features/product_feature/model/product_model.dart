class ProductModel {
  Product? product;
  int? totalPrice;
  List<Gallery>? gallery;
  dynamic percent;
  bool? fav;
  String? brand;
  bool? checkCart;
  List<UserComments>? userComments;

  ProductModel.fromJson(dynamic json) {
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    totalPrice = json['total_price'] ?? 0;
    percent = json['percent'] ?? '0';
    fav = json['fav'];
    brand = json['brand'] ?? '';
    checkCart = json['check_cart'];
    if (json['gallerys'] != null) {
      gallery = [];
      json['gallerys'].forEach((v) {
        gallery?.add(Gallery.fromJson(v));
      });
    }

    if (json['comments'] != null) {
      userComments = [];
      json['comments'].forEach((v) {
        userComments?.add(UserComments.fromJson(v));
      });
    }
  }
}

class UserComments {
  int? commentId;
  String? fullName;
  String? comment;
  String? date;

  UserComments({
    this.commentId,
    this.fullName,
    this.comment,
    this.date,
  });

  UserComments.fromJson(dynamic json) {
    commentId = json['comment_id'];
    fullName = json['fullname'];
    comment = json['comment'];
    date = json['date'];
  }
}

class Gallery {
  int? id;
  String? path;

  Gallery({
    this.id,
    this.path,
  });

  Gallery.fromJson(dynamic json) {
    id = json['id'];
    path = json['path'];
  }
}

class Product {
  int? id;
  String? title;
  String? enName;
  String? defaultPrice;
  String? deliverPrice;
  String? image;
  String? productBody;

  Product({
    this.id,
    this.title,
    this.enName,
    this.defaultPrice,
    this.deliverPrice,
    this.image,
    this.productBody,
  });

  Product.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    enName = json['en_name'];
    defaultPrice = json['default_price'];
    deliverPrice = json['deliver_price'];
    image = json['image'];
    productBody =
        json['product_body'].toString().replaceAll('&zwnj;', '').replaceAll('&nbsp;', '');
  }
}
