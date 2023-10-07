import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/responsive.dart';
import '../../../const/shape/media_query.dart';

class ErrorScreenWidget extends StatelessWidget {
  const ErrorScreenWidget({super.key, required this.errorMsg, required this.function});

  final String errorMsg;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/dontknow.png',
                width: getWidth(context, 0.45),
              ),
              SizedBox(height: 7.5.sp),
              Text(
                errorMsg,
                style: TextStyle(
                  fontFamily: 'bold',
                  fontSize: 18.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.sp),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    getWidth(context, 0.5),
                    Responsive.isTablet(context) ? 60 : 45,
                  ),
                ),
                onPressed: () => function(),
                child: Text(
                  'تلاش مجدد',
                  style: TextStyle(
                    fontFamily: 'bold',
                    fontSize: 16.sp,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
