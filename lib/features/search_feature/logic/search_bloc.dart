import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_prokala/features/public_features/error/error_message_class.dart';
import 'package:flutter_prokala/features/search_feature/model/search_model.dart';
import 'package:meta/meta.dart';

import '../../public_features/error/error_exception.dart';
import '../service/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  SearchBloc(this.searchRepository) : super(SearchInitial()) {
    on<CallSearchEvent>(_searchApi);
  }

  FutureOr<void> _searchApi(CallSearchEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());

    try {
      final SearchModel searchModel = await searchRepository.callSearchApi(event.search);
      emit(SearchCompletedState(searchModel));
    } on DioException catch (e) {
      emit(SearchErrorState(
          errorMessage: ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
    }
  }
}
