import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prokala/const/shape/media_query.dart';
import 'package:flutter_prokala/const/theme/colors.dart';
import 'package:flutter_prokala/features/intro_features/pref/shared_pref.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/responsive.dart';
import '../../public_features/screens/bottom_nav_bar.dart';
import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String screenId = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigate() {
    Timer(const Duration(seconds: 3), () async {


      if (await SharedPref().getIntroStatus()) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          BottomNavBarScreen.screenId,
          (route) => false,
        );
      } else {
        Navigator.of(context).pushReplacementNamed(IntroScreen.screenId);
      }
    });



  }

  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop=Responsive.isDesktop(context);
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: FadeInDown(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius:isDesktop?getWidth(context, 0.05): getWidth(context, 0.16),
                backgroundColor: theme.scaffoldBackgroundColor,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: isDesktop?getWidth(context, 0.05): getWidth(context, 0.16),
                ),
              ),
              SizedBox(height: 10.sp),
              Text(
                'Pro Kala',
                style: TextStyle(
                  color: whiteColor,
                  fontSize:isDesktop?12.sp: 17.sp,
                  fontFamily: 'bold',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.5.sp),
              Text(
                'www.programmingshow.ir',
                style: TextStyle(
                  color: whiteColor,
                  fontSize:isDesktop?8.sp: 13.sp,
                  fontFamily: 'normal',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
