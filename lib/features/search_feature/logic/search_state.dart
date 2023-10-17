part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchCompletedState extends SearchState {

  final SearchModel searchModel;

  SearchCompletedState(this.searchModel);

}

class SearchErrorState extends SearchState {
  final ErrorMessageClass errorMessage;

  SearchErrorState({required this.errorMessage});
}
