part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class AddToFavoriteEvent extends FavoriteEvent {
  final String id;

  AddToFavoriteEvent(this.id);
}


class RemoveFavoriteEvent extends FavoriteEvent{
  final int id;

  RemoveFavoriteEvent(this.id);
}

class CallFavoriteList extends FavoriteEvent {}
