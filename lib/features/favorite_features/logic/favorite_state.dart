part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}
class FavoriteLoadingState extends FavoriteState {}
class FavoriteCompletedState extends FavoriteState {

  final bool status;

  FavoriteCompletedState({required this.status});

}
class FavoriteErrorState extends FavoriteState {

  final ErrorMessageClass errorMessage;

  FavoriteErrorState(this.errorMessage);

}
