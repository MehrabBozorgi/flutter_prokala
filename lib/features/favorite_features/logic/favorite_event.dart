part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class AddToFavoriteEvent extends FavoriteEvent{

  final String id;

  AddToFavoriteEvent(this.id);

}
