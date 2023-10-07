import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_prokala/const/shape/media_query.dart';
import 'package:flutter_prokala/const/theme/colors.dart';
import 'package:flutter_prokala/features/intro_features/logic/intro_cubit.dart';
import 'package:flutter_prokala/features/intro_features/pref/shared_pref.dart';
import 'package:flutter_prokala/features/public_features/screens/bottom_nav_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../const/responsive.dart';
import '../../home_features/screens/home_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  static const String screenId = '/intro_screen';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController pageController = PageController(initialPage: 0);

  List<Widget> pageItem = [
    const PageViewItems(
      image: 'assets/images/intro/Apple-iPad-PNG-Free-Download.png',
      title: 'آسان خرید و فروش کن!',
      description: 'اپلیکیشن تخصصی خرید و فروش الا و نازلترین قیمت',
    ),
    const PageViewItems(
      image: 'assets/images/intro/pngwing.com.png',
      title: 'تخصص حرف اول رو میزنه!',
      description: 'خرید و فروش سریع و آسان همراه با تیم پشتیبانی قوی',
    ),
    const PageViewItems(
      image: 'assets/images/intro/pngwing.com1.png',
      title: 'همه چی اینجا هست!',
      description: 'ثبت  و خرید و فروش عمده تنها با یک کلیک',
    ),
    const PageViewItems(
      image: 'assets/images/intro/Apple-iPad-PNG-Free-Download.png',
      title: 'اعتماد به ایران',
      description: 'تمامی هزینه ها برای پشتیبانی از ایران عزیز مصرف میشود',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: WaveClipperOne(),
            child: Container(
              height: 200,
              color: primaryColor,
            ),
          ),
          Center(
            child: BlocBuilder<IntroCubit, int>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: getWidth(context, 0.65),
                      height:
                      Responsive.isDesktop(context)?350:
                      Responsive.isTablet(context)?400:
                          300
                      ,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: pageItem.length,
                        itemBuilder: (context, index) {
                          return pageItem[index];
                        },
                        onPageChanged: (value) {
                          BlocProvider.of<IntroCubit>(context).changeIndex(value);
                        },
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: pageController,
                      count: pageItem.length,
                      textDirection: TextDirection.rtl,
                      effect: const ExpandingDotsEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        spacing: 5,
                        activeDotColor: primaryColor,
                      ),
                    ),
                    SizedBox(height: 8.sp),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(getWidth(context, 0.3), 40),
                      ),
                      onPressed: () {
                        if (BlocProvider.of<IntroCubit>(context).currentIndex < 3) {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        } else {
                          SharedPref().setIntroStatus();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            BottomNavBarScreen.screenId,
                            (route) => false,
                          );
                        }
                      },
                      child: Text(
                        BlocProvider.of<IntroCubit>(context).currentIndex < 3
                            ? 'ورق بزن'
                            : 'بزن بریم',
                        style: const TextStyle(
                          fontFamily: 'bold',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PageViewItems extends StatelessWidget {
  const PageViewItems({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(
            image,
            height:isDesktop?100: 200,
            errorBuilder: (context, error, stackTrace) => Container(height: isDesktop?100: 200,),
          ),
          SizedBox(height: 10.sp),
          Text(
            title,
            style: TextStyle(
              fontSize: isDesktop ? 8.sp : 16.sp,
              fontFamily: 'bold',
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: isDesktop ? 6.sp : 12.sp,
              fontFamily: 'normal',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
