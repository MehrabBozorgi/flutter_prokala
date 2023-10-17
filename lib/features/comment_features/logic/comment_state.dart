part of 'comment_bloc.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoadingState extends CommentState {}

class CommentCompletedState extends CommentState {
  final CommentModel commentModel;

  CommentCompletedState(this.commentModel);
}

class CommentErrorState extends CommentState {
  final ErrorMessageClass errorMessage;

  CommentErrorState(this.errorMessage);
}
///---- add comment

class AddCommentCompletedState extends CommentState{
  final String msg;

  AddCommentCompletedState(this.msg);
}
class AddCommentErrorState extends CommentState{
  final ErrorMessageClass errorMessage;

  AddCommentErrorState(this.errorMessage);
}
class AddCommentLoadingState extends CommentState{}