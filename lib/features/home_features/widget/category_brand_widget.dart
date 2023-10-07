import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../model/home_model.dart';

class CategoryBrandWidget extends StatelessWidget {
  const CategoryBrandWidget({
    super.key,
    required this.homeModel,
  });

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return homeModel.categoryBanner == null
        ? const SizedBox.shrink()
        : GridView.builder(
            itemCount: homeModel.categoryBanner!.length,
            physics: const NeverScrollableScrollPhysics(),
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
