class CartModel {
  String? cartTotal;
  int? cartCount;
  List<Cart>? cart;

  CartModel.fromJson(dynamic json) {
    if (json['cart'] != null) {
      cart = [];
      json['cart'].forEach((v) {
        cart?.add(Cart.fromJson(v));
      });
    }
    cartTotal = json['cart_total'].toString();
    cartCount = json['cart_count'];
  }

  CartModel({this.cartTotal, this.cartCount, this.cart});
}

class Cart {
  int? cartId;

  String? productId;
  String? productTitle;
  String? productImage;
  String? count;
  int? productPrice;
  int? productDeliveryPrice;

  Cart({
    this.cartId,
    this.productId,
    this.productTitle,
    this.productImage,
    this.count,
    this.productPrice,
    this.productDeliveryPrice,
  });

  Cart.fromJson(dynamic json) {
    cartId = json['cart_id'];
    productId = json['product_id'].toString();
    productTitle = json['product_title'];
    productImage = json['product_image'];
    count = json['count'].toString();
    productPrice = json['product_price'];
    productDeliveryPrice = json['delivery_price'];
  }
}
