part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class CallSearchEvent extends SearchEvent {
  final String search;

  CallSearchEvent(this.search);
}
