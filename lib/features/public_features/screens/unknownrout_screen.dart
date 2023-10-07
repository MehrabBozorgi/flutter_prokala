import 'package:flutter/material.dart';
import 'package:flutter_prokala/const/responsive.dart';
import 'package:flutter_prokala/const/shape/media_query.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnKnowRoutScreen extends StatelessWidget {
  const UnKnowRoutScreen({super.key});

  static const String screenId = '/unknowRout_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/dontknow.png',
              width: getWidth(context, 0.5),
              errorBuilder: (context, error, stackTrace) => Container(
                width: getWidth(context, 0.5),
              ),
            ),
            SizedBox(height: 10.sp),
            Text(
              'صفحه مورد نظر پیدا نشد!!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'bold',
                fontSize:Responsive.isDesktop(context)?12.sp: 18.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
