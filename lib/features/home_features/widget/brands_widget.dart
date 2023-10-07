import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../const/responsive.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../model/home_model.dart';

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
    return homeModel.brands == null
        ? const SizedBox.shrink()
        : Container(
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
