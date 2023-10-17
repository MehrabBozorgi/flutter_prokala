import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/media_query.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key, required this.title,
  });
final String title;
  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty_box.png',
              width: getWidth(context, 0.5),
            ),
            SizedBox(height: 10.sp),
            Text(
             title,
              style: TextStyle(fontFamily: 'bold', fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
