import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../const/responsive.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../logic/cubit/home_cubit.dart';
import '../model/home_model.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    super.key,
    required this.homeModel,
  });

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return homeModel.sliders == null
        ? const SizedBox.shrink()
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