import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prokala/const/responsive.dart';
import 'package:flutter_prokala/const/shape/media_query.dart';
import 'package:flutter_prokala/const/theme/colors.dart';
import 'package:flutter_prokala/features/comment_features/services/comment_repository.dart';
import 'package:flutter_prokala/features/comment_features/widget/text_form_field_multi_line.dart';
import 'package:flutter_prokala/features/public_features/widget/snack_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../logic/comment_bloc.dart';

class AddCommentScreen extends StatefulWidget {
  const AddCommentScreen({super.key});

  static const String screenId = '/add_comment_screen';

  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  final TextEditingController _commeentController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    _commeentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Form(
        key: _key,
        child: BlocProvider(
          create: (context) => CommentBloc(CommentRepository()),
          child: BlocConsumer<CommentBloc, CommentState>(
            listener: (context, state) {
              if (state is AddCommentCompletedState) {
                getSnackBarWidget(context, state.msg, Colors.green);

                Navigator.pop(context);
              }
              if (state is AddCommentErrorState) {
                getSnackBarWidget(context, state.errorMessage.errorMsg!, Colors.red);
              }
            },
            builder: (context, state) {
              if (state is AddCommentLoadingState) {
                return const Center(child: CircularProgressIndicator(color: primaryColor));
              }
              return Padding(
                padding: EdgeInsets.all(12.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: getAllWidth(context),
                      margin: EdgeInsets.only(top: 18.sp),
                      child: Text(
                        'ثبت دیدگاه',
                        style: TextStyle(fontSize: 20.sp, fontFamily: 'bold'),
                      ),
                    ),
                    TextFormFieldMultiLine(
                      minLine: 8,
                      maxLine: 10,
                      labelText: 'دیدگاه',
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.multiline,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      controller: _commeentController,
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                          getAllWidth(context),
                          Responsive.isTablet(context) ? 60 : 45,
                        ),
                      ),
                      onPressed: () {
                        ///call event
                        if (_key.currentState!.validate()) {
                          BlocProvider.of<CommentBloc>(context).add(
                            AddCommentEvent(
                              pid: arguments['product_id'],
                              comment: _commeentController.text,
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'ثبت دیدگاه',
                        style: TextStyle(fontFamily: 'bold'),
                      ),
                    ),
                    SizedBox(height: getWidth(context, 0.1)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
