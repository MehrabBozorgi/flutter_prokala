import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prokala/const/theme/colors.dart';
import 'package:flutter_prokala/features/home_features/logic/bloc/home_bloc.dart';
import 'package:flutter_prokala/features/home_features/model/home_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../public_features/widget/error_screen_widget.dart';
import '../widget/amazing_widget.dart';
import '../widget/brands_widget.dart';
import '../widget/carousel_widget.dart';
import '../widget/category_brand_widget.dart';
import '../widget/product_list_widget.dart';
import '../widget/shimmer_loading.dart';
import '../widget/sliver_search_bar.dart';
import '../widget/top_banner_widget.dart';
import '../widget/two_banner_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String screenId = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<HomeBloc>(context).add(CallHomeEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RefreshIndicator(
      color: primaryColor,
      onRefresh: () async {
        BlocProvider.of<HomeBloc>(context).add(CallHomeEvent());
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const ShimmerLoading();
          }
          if (state is HomeCompletedState) {
            HomeModel homeModel = state.homeModel;

            return CompletedBody(theme: theme, homeModel: homeModel);
          }
          if (state is HomeErrorState) {
            return ErrorScreenWidget(
              errorMsg: state.error.errorMsg.toString(),
              function: () {
                BlocProvider.of<HomeBloc>(context).add(CallHomeEvent());
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}

class CompletedBody extends StatelessWidget {
  const CompletedBody({
    super.key,
    required this.theme,
    required this.homeModel,
  });

  final ThemeData theme;
  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    print(homeModel.colOneId);
    return FadeIn(
      child: CustomScrollView(
        slivers: [
          SliverSearchBar(theme: theme),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.sp),
                    CarouselWidget(homeModel: homeModel),
                    SizedBox(height: 10.sp),
                    BrandsWidget(homeModel: homeModel, theme: theme),
                    SizedBox(height: 15.sp),
                    AmazingWidget(homeModel: homeModel, theme: theme),
                    SizedBox(height: 16.sp),
                    homeModel.random == null
                        ? const SizedBox.shrink()
                        : ProductListWidget(
                            list: homeModel.random!, title: 'محصولات پر فروش', id: null),
                    SizedBox(height: 16.sp),
                    CategoryBrandWidget(homeModel: homeModel),
                    SizedBox(height: 15.sp),
                    homeModel.colOne == null
                        ? const SizedBox.shrink()
                        : ProductListWidget(
                            list: homeModel.colOne!,
                            title: homeModel.colOneName,
                            id: homeModel.colOneId,
                          ),
                    SizedBox(height: 10.sp),
                    TwoBannersWidget(homeModel: homeModel),
                    SizedBox(height: 15.sp),
                    homeModel.colTwo == null
                        ? const SizedBox.shrink()
                        : ProductListWidget(
                            list: homeModel.colTwo!,
                            title: homeModel.colTwoName,
                            id: homeModel.colTwoId,
                          ),
                    TopBannerWidget(homeModel: homeModel),
                    SizedBox(height: 10.sp),
                    homeModel.colThree == null
                        ? const SizedBox.shrink()
                        : ProductListWidget(
                            list: homeModel.colThree!,
                            title: homeModel.colThreeName,
                            id: homeModel.colThreeId,
                          ),
                    homeModel.colFour == null
                        ? const SizedBox.shrink()
                        : ProductListWidget(
                            list: homeModel.colFour!,
                            title: homeModel.colFourName,
                            id: homeModel.colFourId,
                          ),
                    homeModel.colFive == null
                        ? const SizedBox.shrink()
                        : ProductListWidget(
                            list: homeModel.colFive!,
                            title: homeModel.colFiveName,
                            id: homeModel.colFiveId,
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
