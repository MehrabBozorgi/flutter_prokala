import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/responsive.dart';
import '../../../const/shape/border_radius.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({
    super.key,
    required this.list,
    this.title,
  });

  final List<dynamic>? list;
  final String? title;

  @override
  Widget build(BuildContext context) {

    return  Container(
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
                  itemCount: list!.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(15.sp),
                      child: ClipRRect(
                        borderRadius: getBorderRadiusFunc(10),
                        child: FadeInImage(
                          placeholder: const AssetImage('assets/images/logo.png'),
                          image: NetworkImage(list![index].image!),
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