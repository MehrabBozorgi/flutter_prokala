import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_prokala/features/cart_feature/model/cart_model.dart';
import 'package:flutter_prokala/features/public_features/error/error_message_class.dart';
import 'package:meta/meta.dart';

import '../../public_features/error/error_exception.dart';
import '../services/cart_repository.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc(this.cartRepository) : super(CartInitial()) {
    on<AddToCartEvent>(_addToCart);
    on<CallShowCartEvent>(_showCartApi);
    on<ChangeCartCountEvent>(_changeCartCount);
    on<DeleteItemCartEvent>(_deleteItem);
    on<DeleteAllItemsCartEvent>(_deleteAllItems);
  }

  CartModel cartModel = CartModel();
  String totalPrice = '';

  FutureOr<void> _addToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());

    try {
      cartRepository.addToCart(event.id);
      emit(CartCompletedState());
    } on DioException catch (e) {
      emit(CartErrorState(ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
    }
  }

  FutureOr<void> _showCartApi(CallShowCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());

    try {
      cartModel = await cartRepository.callShowCart();

      emit(ShowCartCompletedState(cartModel));
    } on DioException catch (e) {
      emit(CartErrorState(ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
    }
  }

  FutureOr<void> _changeCartCount(ChangeCartCountEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());

    Cart currentCartItem =
        cartModel.cart!.firstWhere((element) => element.cartId == int.parse(event.cartId));
    try {
      cartModel.cartTotal = await cartRepository.changeCartCount(
          pId: event.productId, cartId: event.cartId, newCount: event.count);

      currentCartItem.count = event.count;

      emit(ChangeCountCompletedState(totalPrice));
      emit(ShowCartCompletedState(cartModel));
    } on DioException catch (e) {
      emit(CartErrorState(ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
    }
  }

  FutureOr<void> _deleteItem(DeleteItemCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    Cart currentCartItem =
        cartModel.cart!.firstWhere((element) => element.cartId == int.parse(event.cartId));
    try {
      await cartRepository.deleteItem(event.cartId);

      cartModel.cart!.removeWhere((element) => element.cartId == int.parse(event.cartId));
      final price = (currentCartItem.productPrice! + currentCartItem.productDeliveryPrice!);
      cartModel.cartTotal = (int.parse( cartModel.cartTotal!) - price).toString();



      emit(CompletedDeleteCartItem());
      emit(ShowCartCompletedState(cartModel));
    } on DioException catch (e) {
      emit(CartErrorState(ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
    }
  }

  FutureOr<void> _deleteAllItems(
      DeleteAllItemsCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    try {
      await cartRepository.deleteAllItems();
      cartModel.cart!.clear();
      emit(CompletedDeleteAllCartItem());
      emit(ShowCartCompletedState(cartModel));
    } on DioException catch (e) {
      emit(CartErrorState(ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
    }
  }
}
