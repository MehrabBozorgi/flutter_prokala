part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}


class CallShowComment extends CommentEvent{
  final String productId;

  CallShowComment(this.productId);
}

class AddCommentEvent extends CommentEvent{

  final String pid;
  final String comment;

  AddCommentEvent({required this.pid, required this.comment});

}