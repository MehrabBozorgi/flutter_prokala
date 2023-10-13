part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class CallProductEvent extends ProductEvent{
  final String id;

  CallProductEvent(this.id);
}
