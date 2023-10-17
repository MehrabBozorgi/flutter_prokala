import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_prokala/features/category_features/model/category_model.dart';
import 'package:flutter_prokala/features/public_features/error/error_exception.dart';
import 'package:flutter_prokala/features/public_features/error/error_message_class.dart';
import 'package:meta/meta.dart';

import '../model/all_category_model.dart';
import '../services/category_repository.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<CallCategory>((event, emit) async {
      emit(CategoryLoadingState());

      try {
        CategoryModel categoryModel = await repository.fetchCategory();
        emit(CategoryCompletedState(categoryModel));
      } on DioException catch (e) {
        emit(CategoryErrorState(ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
      }
    });

    on<CallAllCategoryEvent>((event, emit) async {
      emit(AllCategoryLoadingState());

      try {
        AllCategoryModel allCategoryModel = await repository.callCategoryModel(event.id);
        emit(AllCategoryCompletedState(allCategoryModel));
      } on DioException catch (e) {
        emit(AllCategoryErrorState(
            ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
      }
    });
  }
}
