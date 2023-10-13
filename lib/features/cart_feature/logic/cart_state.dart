part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartCompletedState extends CartState {}

class CartErrorState extends CartState {
  final ErrorMessageClass errorMessage;

  CartErrorState(this.errorMessage);
}

///---- show cart
class ShowCartCompletedState extends CartState {
  final CartModel cartModel;

  ShowCartCompletedState(this.cartModel);
}

///--- cart count
class ChangeCountCompletedState extends CartState {
  final String totalPrice;

  ChangeCountCompletedState(this.totalPrice);
}

///--- class Delete item
class CompletedDeleteCartItem extends CartState {}
class CompletedDeleteAllCartItem extends CartState {}
