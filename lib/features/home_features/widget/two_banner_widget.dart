import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../const/shape/border_radius.dart';
import '../model/home_model.dart';

class TwoBannersWidget extends StatelessWidget {
  const TwoBannersWidget({
    super.key,
    required this.homeModel,
  });

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return homeModel.twoBanner == null
        ? const SizedBox.shrink()
        : ListView.builder(
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
