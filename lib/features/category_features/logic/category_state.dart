part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryCompletedState extends CategoryState {
  final CategoryModel categoryModel;

  CategoryCompletedState(this.categoryModel);
}

class CategoryErrorState extends CategoryState {
  final ErrorMessageClass error;

  CategoryErrorState(this.error);
}


/// all category
class AllCategoryLoadingState extends CategoryState{}
class AllCategoryCompletedState extends CategoryState{
  final AllCategoryModel allCategoryModel;

  AllCategoryCompletedState(this.allCategoryModel);
}
class AllCategoryErrorState extends CategoryState{
  final ErrorMessageClass error;

  AllCategoryErrorState(this.error);
}