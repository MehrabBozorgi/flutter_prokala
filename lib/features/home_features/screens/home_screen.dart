import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prokala/const/responsive.dart';
import 'package:flutter_prokala/const/shape/border_radius.dart';
import 'package:flutter_prokala/const/shape/media_query.dart';
import 'package:flutter_prokala/const/theme/colors.dart';
import 'package:flutter_prokala/features/home_features/logic/bloc/home_bloc.dart';
import 'package:flutter_prokala/features/home_features/model/home_model.dart';
import 'package:flutter_prokala/features/public_features/functions/number_to_three.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../logic/cubit/home_cubit.dart';

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
      child: CustomScrollView(
        slivers: [
          SliverSearchBar(theme: theme),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return const ShimmerLoading();
                    }
                    if (state is HomeCompletedState) {
                      HomeModel homeModel = state.homeModel;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5.sp),
                          CarouselWidget(homeModel: homeModel),
                          SizedBox(height: 10.sp),
                          BrandsWidget(homeModel: homeModel, theme: theme),
                          SizedBox(height: 15.sp),
                          AmazingWidget(homeModel: homeModel, theme: theme),
                          SizedBox(height: 16.sp),
                          ProductListWidget(list: homeModel.random!, title: 'محصولات پر فروش'),
                          SizedBox(height: 16.sp),
                          CategoryBrandWidget(homeModel: homeModel),
                          SizedBox(height: 15.sp),
                          ProductListWidget(
                            list: homeModel.colOne!,
                            title: homeModel.colOneName,
                          ),
                          SizedBox(height: 10.sp),
                          TwoBannersWidget(homeModel: homeModel),
                          SizedBox(height: 15.sp),
                          ProductListWidget(
                            list: homeModel.colTwo!,
                            title: homeModel.colTwoName,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.sp),
                            child: ClipRRect(
                              borderRadius: getBorderRadiusFunc(10),
                              child: FadeInImage(
                                placeholder: const AssetImage('assets/images/logo.png'),
                                image: NetworkImage(homeModel.topBanner!.image!),
                                width: getAllWidth(context),
                                height: getWidth(context, 0.15),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.sp),
                          ProductListWidget(
                            list: homeModel.colThree!,
                            title: homeModel.colThreeName,
                          ),
                          ProductListWidget(
                            list: homeModel.colFour!,
                            title: homeModel.colFourName,
                          ),
                          ProductListWidget(
                            list: homeModel.colFive!,
                            title: homeModel.colFiveName,
                          ),
                        ],
                      );
                    }
                    if (state is HomeErrorState) {
                      return Center(
                        child: Text(state.error.errorMsg.toString()),
                      );
                    }

                    return Container();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TwoBannersWidget extends StatelessWidget {
  const TwoBannersWidget({
    super.key,
    required this.homeModel,
  });

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: homeModel.twoBanner!.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            final url = homeModel.twoBanner![index].link;
            if (await canLaunchUrlString(url!)) {
              launchUrlString(url);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: ClipRRect(
              borderRadius: getBorderRadiusFunc(10),
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/logo.png'),
                image: NetworkImage(homeModel.twoBanner![index].image!),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CategoryBrandWidget extends StatelessWidget {
  const CategoryBrandWidget({
    super.key,
    required this.homeModel,
  });

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: homeModel.categoryBanner!.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.75,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            final url = homeModel.categoryBanner![index].link;
            if (await canLaunchUrlString(url!)) {
              launchUrlString(url);
            }
          },
          child: ClipRRect(
            borderRadius: getBorderRadiusFunc(12.5),
            child: FadeInImage(
              placeholder: const AssetImage('assets/images/logo.png'),
              image: NetworkImage(homeModel.categoryBanner![index].image!),
              height: getWidth(context, 0.32),
              width: getAllWidth(context),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({
    super.key,
    required this.list,
    this.title,
  });

  final List<dynamic> list;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: TextStyle(
              fontSize: Responsive.isTablet(context) ? 16.sp : 18.sp,
              fontFamily: 'bold',
            ),
            textAlign: TextAlign.right,
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(15.sp),
                child: ClipRRect(
                  borderRadius: getBorderRadiusFunc(10),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/images/logo.png'),
                    image: NetworkImage(list[index].image!),
                  ),
                ),
              );
            },
          ),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                'مشاهده همه',
                style: TextStyle(
                  fontSize: Responsive.isTablet(context) ? 13.sp : 16.sp,
                  fontFamily: 'bold',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AmazingWidget extends StatelessWidget {
  const AmazingWidget({
    super.key,
    required this.homeModel,
    required this.theme,
  });

  final HomeModel homeModel;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getAllWidth(context),
      height: Responsive.isTablet(context) ? getWidth(context, 0.55) : getWidth(context, 0.65),
      color: primaryColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              width: getWidth(context, 0.25),
              margin: EdgeInsets.symmetric(
                horizontal: getWidth(context, 0.02),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'پیشنهادات ویژه',
                    style: TextStyle(
                      fontFamily: 'bold',
                      fontSize: Responsive.isTablet(context) ? 16.sp : 17.sp,
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                  FadeInImage(
                    placeholder: const AssetImage('assets/images/logo.png'),
                    image: const AssetImage('assets/images/amazing/amazing_box.png'),
                    width: getWidth(context, 0.25),
                  ),
                ],
              ),
            ),
            ListView.builder(
              itemCount: homeModel.amazing!.length,
              padding: EdgeInsets.symmetric(horizontal: getWidth(context, 0.02)),
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final helper = homeModel.amazing![index];
                return AmazingItems(theme: theme, helper: helper);
              },
            )
          ],
        ),
      ),
    );
  }
}

class AmazingItems extends StatelessWidget {
  const AmazingItems({super.key, required this.theme, required this.helper});

  final ThemeData theme;
  final Amazing helper;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getWidth(context, 0.02)),
      margin: EdgeInsets.symmetric(
        vertical: getWidth(context, 0.03),
        horizontal: getWidth(context, 0.015),
      ),
      width: getWidth(context, 0.375),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: getBorderRadiusFunc(10),
      ),
      child: GestureDetector(
        onTap: () {
          ///onTap
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(6.sp),
                child: ClipRRect(
                  borderRadius: getBorderRadiusFunc(7.5),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/images/logo.png'),
                    image: NetworkImage(helper.image!),
                    width: Responsive.isTablet(context)
                        ? getWidth(context, 0.225)
                        : getWidth(context, 0.275),
                    height: Responsive.isTablet(context)
                        ? getWidth(context, 0.225)
                        : getWidth(context, 0.275),
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                helper.title!,
                style: TextStyle(
                  fontFamily: 'bold',
                  fontSize: Responsive.isTablet(context) ? 14.sp : 16.sp,
                ),
                maxLines: 2,
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getWidth(context, 0.02),
                      vertical: getWidth(context, 0.015),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: getBorderRadiusFunc(50),
                    ),
                    child: Text(
                      '% ${helper.percent!}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'bold',
                        color: Colors.white,
                        fontSize: Responsive.isTablet(context) ? 13.sp : 14.sp,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getPriceFormat(helper.percentPrice.toString()),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'bold',
                          fontSize: Responsive.isTablet(context) ? 14.sp : 16.sp,
                        ),
                        maxLines: 1,
                      ),
                      Text(
                        getPriceFormat(helper.defaultPrice!),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'normal',
                            fontSize: Responsive.isTablet(context) ? 13.sp : 14.sp,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BrandsWidget extends StatelessWidget {
  const BrandsWidget({
    super.key,
    required this.homeModel,
    required this.theme,
  });

  final HomeModel homeModel;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getWidth(context, 0.04)),
      width: getAllWidth(context),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: homeModel.brands!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Responsive.isTablet(context) ? 5 : 4,
            crossAxisSpacing: 45,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return BrandsItemsWidget(homeModel: homeModel, theme: theme, index: index);
        },
      ),
    );
  }
}

class BrandsItemsWidget extends StatelessWidget {
  const BrandsItemsWidget({
    super.key,
    required this.homeModel,
    required this.theme,
    required this.index,
  });

  final HomeModel homeModel;
  final ThemeData theme;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final url = homeModel.brands![index].link;
        if (await canLaunchUrlString(url!)) {
          launchUrlString(url);
        }
      },
      child: Container(
        padding: EdgeInsets.all(5.sp),
        decoration: ShapeDecoration(
          color: theme.scaffoldBackgroundColor,
          shadows: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.7),
              blurRadius: 10,
              spreadRadius: -12,
              offset: const Offset(0.1, 10),
            ),
          ],
          shape: ContinuousRectangleBorder(
            borderRadius: getBorderRadiusFunc(40),
          ),
        ),
        child: FadeInImage(
          placeholder: const AssetImage('assets/images/logo.png'),
          image: NetworkImage(homeModel.brands![index].image!),
        ),
      ),
    );
  }
}

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    super.key,
    required this.homeModel,
  });

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return homeModel.sliders == null
        ? Container()
        : BlocProvider(
            create: (context) => HomeCubit(),
            child: BlocBuilder<HomeCubit, int>(
              builder: (context, state) {
                return Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: homeModel.sliders!.length,
                      itemBuilder: (context, index, realIndex) {
                        return GestureDetector(
                          onTap: () async {
                            final url = homeModel.sliders![index].link;
                            if (await canLaunchUrlString(url!)) {
                              await launchUrlString(url, mode: LaunchMode.externalApplication);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: getBorderRadiusFunc(7.5),
                              child: FadeInImage(
                                placeholder: const AssetImage('assets/images/logo.png'),
                                image: NetworkImage(homeModel.sliders![index].image!),
                                fit: BoxFit.cover,
                                imageErrorBuilder: (context, error, stackTrace) =>
                                    Image.asset('assets/images/logo.png'),
                                placeholderErrorBuilder: (context, error, stackTrace) =>
                                    Container(),
                              ),
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: Responsive.isTablet(context)
                            ? getWidth(context, 0.33)
                            : getWidth(context, 0.43),
                        viewportFraction: 0.95,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          BlocProvider.of<HomeCubit>(context).changeCurrentIndex(index);
                        },
                      ),
                    ),
                    AnimatedSmoothIndicator(
                      activeIndex: BlocProvider.of<HomeCubit>(context).currentIndex,
                      count: homeModel.sliders!.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: primaryColor,
                        dotWidth: Responsive.isTablet(context) ? 5.sp : 8.5.sp,
                        dotHeight: Responsive.isTablet(context) ? 5.sp : 8.5.sp,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
  }
}

class SliverSearchBar extends StatelessWidget {
  const SliverSearchBar({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      forceElevated: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      toolbarHeight: Responsive.isTablet(context) ? 80 : 65,
      pinned: true,
      flexibleSpace: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(context, 0.02), vertical: 8.sp),
        child: GestureDetector(
          onTap: () {
            ///on tap
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context, 0.03)),
            height: Responsive.isTablet(context) ? 60 : 45,
            decoration: BoxDecoration(
              color: textFieldColor,
              borderRadius: getBorderRadiusFunc(4),
            ),
            child: Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: getWidth(context, 0.01)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'جستجو در ',
                      style: Responsive.isTablet(context)
                          ? TextStyle(fontSize: 14.sp, fontFamily: 'bold')
                          : TextStyle(fontSize: 16.sp, fontFamily: 'bold'),
                    ),
                    Text(
                      'پروکالا',
                      style: TextStyle(
                          color: primaryColor,
                          fontFamily: 'bold',
                          fontSize: Responsive.isTablet(context) ? 15.sp : 18.sp),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Center(
        child: Column(
          children: [
            Container(
              width: getWidth(context, 0.95),
              height: 125,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: getBorderRadiusFunc(5),
              ),
            ),
            SizedBox(height: 10.sp),
            const Wrap(
              children: [
                LittleShimmer(),
                LittleShimmer(),
                LittleShimmer(),
                LittleShimmer(),
                LittleShimmer(),
                LittleShimmer(),
                LittleShimmer(),
                LittleShimmer(),
                LittleShimmer(),
                LittleShimmer(),
              ],
            ),
            SizedBox(height: 10.sp),
            Container(
              width: getWidth(context, 0.95),
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: getBorderRadiusFunc(5),
              ),
            ),
            SizedBox(height: 10.sp),
            Container(
              width: getWidth(context, 0.95),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: getBorderRadiusFunc(5),
              ),
            ),
            SizedBox(height: 10.sp),
            Container(
              width: getWidth(context, 0.95),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: getBorderRadiusFunc(5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LittleShimmer extends StatelessWidget {
  const LittleShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(getWidth(context, 0.02)),
      width: getWidth(context, 0.15),
      height: getWidth(context, 0.15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: getBorderRadiusFunc(5),
      ),
    );
  }
}
