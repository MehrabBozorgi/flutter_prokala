part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}


class CallCategory extends CategoryEvent{}


class CallAllCategoryEvent extends CategoryEvent{

  final String id;

  CallAllCategoryEvent(this.id);

}
