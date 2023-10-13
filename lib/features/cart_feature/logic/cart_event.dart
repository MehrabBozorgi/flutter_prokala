part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final String id;

  AddToCartEvent(this.id);
}

class CallShowCartEvent extends CartEvent {}

class ChangeCartCountEvent extends CartEvent {
  final String productId;
  final String cartId;
  final String count;

  ChangeCartCountEvent({required this.productId, required this.cartId, required this.count});
}

class DeleteItemCartEvent extends CartEvent {
  final String cartId;

  DeleteItemCartEvent(this.cartId);
}

class DeleteAllItemsCartEvent extends CartEvent{}