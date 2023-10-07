import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/responsive.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/number_to_three.dart';
import '../model/home_model.dart';

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
    return  homeModel.amazing==null ?const SizedBox.shrink():Container(
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