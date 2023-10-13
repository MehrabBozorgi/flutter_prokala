import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../const/responsive.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../logic/cubit/product_cubit.dart';
import '../model/product_model.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({super.key, required this.helper, required this.carousel});

  final ProductModel helper;
  final List<String> carousel;

  @override
  Widget build(BuildContext context) {
    return carousel.isEmpty
        ? FadeInImage(
            placeholder: const AssetImage('assets/images/logo.png'),
            image: NetworkImage(helper.product!.image!),
            placeholderErrorBuilder: (context, error, stackTrace) => Container(),
            height:
                Responsive.isTablet(context) ? getWidth(context, 0.4) : getWidth(context, 0.5),
            width: getAllWidth(context),
          )
        : ProductCarouselWidget(carousel: carousel);
  }
}

class ProductCarouselWidget extends StatelessWidget {
  const ProductCarouselWidget({
    super.key,
    required this.carousel,
  });

  final List<String> carousel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(),
      child: BlocBuilder<ProductCubit, int>(
        builder: (context, state) {
          return Stack(
            children: [
              CarouselSlider.builder(
                itemCount: carousel.length,
                itemBuilder: (context, index, realIndex) {
                  return ClipRRect(
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/images/logo.png'),
                      image: NetworkImage(carousel[index]),
                      placeholderErrorBuilder: (context, error, stackTrace) => Container(),
                      width: getAllWidth(context),
                    ),
                  );
                },
                options: CarouselOptions(
                    viewportFraction: 1.0,
                    height: Responsive.isTablet(context)
                        ? getWidth(context, 0.4)
                        : getWidth(context, 0.5),
                    onPageChanged: (index, value) {
                      BlocProvider.of<ProductCubit>(context).changeIndex(index);
                    }),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: getBorderRadiusFunc(20),
                  ),
                  child: AnimatedSmoothIndicator(
                    activeIndex: BlocProvider.of<ProductCubit>(context).currentIndex,
                    count: carousel.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.red.shade100,
                      activeDotColor: primaryColor,
                      dotWidth: Responsive.isTablet(context) ? 5.sp : 8.5.sp,
                      dotHeight: Responsive.isTablet(context) ? 5.sp : 8.5.sp,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
