import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_prokala/features/category_features/model/category_model.dart';
import 'package:flutter_prokala/features/home_features/logic/bloc/home_bloc.dart';
import 'package:flutter_prokala/features/public_features/error/error_exception.dart';
import 'package:flutter_prokala/features/public_features/error/error_message_class.dart';
import 'package:meta/meta.dart';

import '../services/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      emit(CategoryLoadingState());

      try {
        CategoryModel categoryModel = await repository.fetchCategory();
        emit(CategoryCompletedState(categoryModel));
      } on DioException catch (e) {
        emit(CategoryErrorState(ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
      }
    });
  }
}
