import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_prokala/features/home_features/model/home_model.dart';
import 'package:flutter_prokala/features/public_features/error/error_exception.dart';
import 'package:flutter_prokala/features/public_features/error/error_message_class.dart';
import 'package:meta/meta.dart';

import '../../services/home_respository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc(this.homeRepository) : super(HomeInitial()) {
    on<CallHomeEvent>(_callHomeApi);
  }

  FutureOr<void> _callHomeApi(CallHomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    try {
      HomeModel _homeMode = await homeRepository.callIndexApi();

      emit(HomeCompletedState(_homeMode));
    } on DioException catch (e) {
      emit(HomeErrorState(error: ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
    }
  }
}
