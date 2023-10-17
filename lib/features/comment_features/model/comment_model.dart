class CommentModel {
  CommentModel({
    this.status,
    this.allComments,
  });

  CommentModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['all_comments'] != null) {
      allComments = [];
      json['all_comments'].forEach((v) {
        allComments?.add(AllComments.fromJson(v));
      });
    }
  }

  int? status;
  List<AllComments>? allComments;
}

class AllComments {
  AllComments({
    this.commentId,
    this.fullname,
    this.comment,
    this.commentReplay,
    this.date,
  });

  AllComments.fromJson(dynamic json) {
    commentId = json['comment_id'];
    fullname = json['fullname'];
    comment = json['comment'];
    commentReplay = json['comment_replay'];
    date = json['date'].toString().replaceAll('.', '/');
  }

  int? commentId;
  String? fullname;
  String? comment;
  dynamic commentReplay;
  String? date;
}
