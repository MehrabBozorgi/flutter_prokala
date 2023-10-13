part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoadingSate extends ProductState{}
class ProductCompletedSate extends ProductState{

  final ProductModel productModel;

  ProductCompletedSate(this.productModel);

}
class ProductErrorSate extends ProductState{
  final ErrorMessageClass errorMessage;

  ProductErrorSate(this.errorMessage);
}
