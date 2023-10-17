import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prokala/const/theme/colors.dart';
import 'package:flutter_prokala/features/category_features/screen/all_category_screen.dart';
import 'package:flutter_prokala/features/public_features/widget/error_screen_widget.dart';
import 'package:flutter_prokala/features/search_feature/logic/search_bloc.dart';
import 'package:flutter_prokala/features/search_feature/service/search_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/media_query.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const String screenId = '/search_screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(SearchRepository()),
      child: WillPopScope(
        onWillPop: () async {
          var currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            currentFocus.focusedChild!.unfocus();
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Builder(builder: (context) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(context, 0.03)),
                    margin: EdgeInsets.symmetric(vertical: getWidth(context, 0.02)),

                    child: TextField(
                      style: TextStyle(fontFamily: 'normal'),
                      textAlignVertical: TextAlignVertical.center,
                      textDirection: TextDirection.rtl,
                      controller: _controller,
                      maxLength: 20,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                        counter: const SizedBox.shrink(),
                      ),
                      onSubmitted: (value) {
                        if (_controller.text.trim().length <= 1 || _controller.text.isEmpty) {
                        } else {
                          BlocProvider.of<SearchBloc>(context)
                              .add(CallSearchEvent(_controller.text));
                        }
                      },
                      onTap: () {
                        if (_controller.text.isNotEmpty) {
                          if (_controller.text[_controller.text.length - 1] != ' ') {
                            _controller.text = (_controller.text + ' ');
                          }
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        if (state is SearchLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(color: primaryColor),
                          );
                        }
                        if (state is SearchCompletedState) {
                          return state.searchModel.searchProduct == null
                              ? Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/dontknow.png',
                                        width: getWidth(context, 0.5),
                                      ),
                                      SizedBox(height: getHeight(context, 0.05)),
                                      Text(
                                        'محصولی که دنبالش هستید پیدا نشد',
                                        style: TextStyle(fontFamily: 'bold', fontSize: 16.sp),
                                      )
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: state.searchModel.searchProduct!.length,
                                  itemBuilder: (context, index) {
                                    return AllCategoryItem(
                                        helper: state.searchModel.searchProduct![index]);
                                  },
                                );
                        }
                        if (state is SearchErrorState) {
                          return ErrorScreenWidget(
                            errorMsg: state.errorMessage.errorMsg!,
                            function: () {
                              BlocProvider.of<SearchBloc>(context)
                                  .add(CallSearchEvent(_controller.text));
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
