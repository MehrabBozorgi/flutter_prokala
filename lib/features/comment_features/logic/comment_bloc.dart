import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_prokala/features/comment_features/model/comment_model.dart';
import 'package:flutter_prokala/features/public_features/error/error_message_class.dart';
import 'package:meta/meta.dart';

import '../../public_features/error/error_exception.dart';
import '../services/comment_repository.dart';

part 'comment_event.dart';

part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;

  CommentBloc(this.commentRepository) : super(CommentInitial()) {
    on<CallShowComment>((event, emit) async {
      emit(CommentLoadingState());

      try {
        final CommentModel commentModel =
            await commentRepository.callShowComment(event.productId);
        emit(CommentCompletedState(commentModel));
      } on DioException catch (e) {
        emit(CommentErrorState(ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
      }
    });

    on<AddCommentEvent>((event, emit) async {
      emit(AddCommentLoadingState());

      try {
        final String massage = await commentRepository.addProduct(event.comment, event.pid);

        emit(AddCommentCompletedState(massage));
      } on DioException catch (e) {
        emit(
            AddCommentErrorState(ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
      }
    });
  }
}
