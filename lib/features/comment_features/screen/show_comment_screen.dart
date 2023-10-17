import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prokala/const/shape/shape.dart';
import 'package:flutter_prokala/const/theme/colors.dart';
import 'package:flutter_prokala/features/comment_features/logic/comment_bloc.dart';
import 'package:flutter_prokala/features/comment_features/screen/add_comment_screen.dart';
import 'package:flutter_prokala/features/comment_features/services/comment_repository.dart';
import 'package:flutter_prokala/features/public_features/logic/token_check/token_check_cubit.dart';
import 'package:flutter_prokala/features/public_features/widget/empty_widget.dart';
import 'package:flutter_prokala/features/public_features/widget/snack_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/media_query.dart';

class ShowCommentScreen extends StatelessWidget {
  const ShowCommentScreen({super.key});

  static const String screenId = '/show_comments_screen';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'دیدگاه ها',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium!.color,
            fontFamily: 'bold',
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<TokenCheckCubit, TokenCheckState>(
        builder: (context, state) {
          if (state is TokenCheckIsLog) {
            return FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AddCommentScreen.screenId,
                  arguments: {'product_id': arguments['product_id']},
                );
              },
              label: Row(
                children: [
                  const Text(
                    'ثبت نظر',
                    style: TextStyle(fontFamily: 'bold'),
                  ),
                  SizedBox(width: 5.sp),
                  const Icon(Icons.add_comment_outlined),
                ],
              ),
            );
          } else {
            return FloatingActionButton.extended(
              backgroundColor: primary2Color,
              onPressed: () {
                getSnackBarWidget(context, 'وارد حساب کاربری خود شوید', Colors.red);
              },
              label: const Text(
                'ورود حساب کاربری',
                style: TextStyle(fontFamily: 'bold'),
              ),
            );
          }
        },
      ),
      body: BlocProvider(
        create: (context) => CommentBloc(CommentRepository())
          ..add(
            CallShowComment(arguments['product_id']),
          ),
        child: BlocBuilder<CommentBloc, CommentState>(
          builder: (context, state) {
            if (state is CommentLoadingState) {
              return const Center(child: CircularProgressIndicator(color: primaryColor));
            }
            if (state is CommentCompletedState) {
              return RefreshIndicator(
                color: primaryColor,
                onRefresh: () async {
                  BlocProvider.of<CommentBloc>(context)
                      .add(CallShowComment(arguments['product_id']));
                  // context.read<CommentBloc>().add(CallShowComment(arguments['product_id']));
                },
                child: state.commentModel.allComments!.isEmpty
                    ? const EmptyWidget(
                        title: 'دیدگاهی برای این محصول ثبت نشده',
                      )
                    : ListView.builder(
                        itemCount: state.commentModel.allComments!.length,
                        itemBuilder: (context, index) {
                          final helper = state.commentModel.allComments![index];

                          return Card(
                            margin: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
                            shape: getShapeFunc(10),
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 15.sp, vertical: 12.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    helper.fullname ?? 'کاربر',
                                    style: TextStyle(fontFamily: 'bold', fontSize: 14.sp),
                                  ),
                                  Text(
                                    helper.comment!,
                                    style: TextStyle(fontFamily: 'normal', fontSize: 14.sp),
                                  ),
                                  SizedBox(height: 10.sp),
                                  Text(
                                    helper.date!,
                                    style: TextStyle(fontFamily: 'bold', fontSize: 14.sp),
                                  ),
                                  SizedBox(height: getWidth(context, 0.04)),
                                  helper.commentReplay == null
                                      ? const Text(
                                          'بدون پاسخ',
                                          style: TextStyle(fontFamily: 'bold'),
                                        )
                                      : RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: ': پاسخ ادمین ',
                                                style: TextStyle(
                                                  fontFamily: 'normal',
                                                  fontSize: 14.sp,
                                                  color: primary2Color,
                                                ),
                                              ),
                                              TextSpan(
                                                text: helper.commentReplay,
                                                style: TextStyle(
                                                  fontFamily: 'normal',
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .color,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              );
            }
            if (state is CommentErrorState) {}

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
