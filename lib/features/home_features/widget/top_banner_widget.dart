import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../model/home_model.dart';

class TopBannerWidget extends StatelessWidget {
  const TopBannerWidget({
    super.key,
    required this.homeModel,
  });

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return homeModel.topBanner == null
        ? const SizedBox.shrink()
        : Padding(
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
          );
  }
}
