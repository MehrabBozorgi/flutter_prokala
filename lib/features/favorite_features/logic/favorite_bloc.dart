import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_prokala/features/public_features/error/error_message_class.dart';
import 'package:meta/meta.dart';

import '../../public_features/error/error_exception.dart';
import '../services/favorite_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteBloc(this.favoriteRepository) : super(FavoriteInitial()) {
    on<AddToFavoriteEvent>(_addToCart);
  }

  FutureOr<void> _addToCart(AddToFavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());

    try {
      final bool status = await favoriteRepository.addToFavorite(event.id);
      emit(FavoriteCompletedState(status: status));
    } on DioException catch (e) {
      emit(FavoriteErrorState(ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
    }
  }
}
