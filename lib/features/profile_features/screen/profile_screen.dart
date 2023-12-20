import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prokala/const/responsive.dart';
import 'package:flutter_prokala/const/shape/media_query.dart';
import 'package:flutter_prokala/const/theme/colors.dart';
import 'package:flutter_prokala/features/authentication_features/services/auth_repository.dart';
import 'package:flutter_prokala/features/favorite_features/screen/favorite_screen.dart';
import 'package:flutter_prokala/features/home_features/widget/sliver_search_bar.dart';
import 'package:flutter_prokala/features/intro_features/screens/splash_screen.dart';
import 'package:flutter_prokala/features/public_features/logic/change_theme/change_theme_cubit.dart';
import 'package:flutter_prokala/features/public_features/widget/snack_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../authentication_features/logic/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        SliverSearchBar(theme: theme),
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              Column(
                children: [
                  SizedBox(height: 10.sp),
                  CircleAvatar(
                    radius: getWidth(context, 0.1),
                    backgroundColor: Colors.red.shade100,
                    child: Icon(
                      Icons.person,
                      color: primaryColor,
                      size: getWidth(context, 0.07),
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  Text(
                    'کاربر عزیز',
                    style: TextStyle(fontFamily: 'bold', fontSize: 16.sp),
                  ),
                  SizedBox(height: 45.sp),
                  ListTile(
                    title: Text(
                      'علاقه مندی ها',
                      style: TextStyle(fontFamily: 'bold', fontSize: 16.sp),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      Navigator.of(context).pushNamed(FavoriteScreen.screenId);
                    },
                  ),

                  ListTile(
                    title: Text(
                      'تغییر تم',
                      style: TextStyle(fontFamily: 'bold', fontSize: 16.sp),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {

                      BlocProvider.of<ChangeThemeCubit>(context).changeTheme();

                    },
                  ),

                  const AboutUsWidget(),
                  const LogOutWidget(),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          const Icon(Icons.logout, color: Colors.red),
          SizedBox(width: getWidth(context, 0.02)),
          Text(
            'خروج از حساب کاربری',
            style: TextStyle(
                fontFamily: 'bold', fontSize: 16.sp, color: Colors.red),
          ),
        ],
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.red,
      ),
      onTap: () {
        showModalBottomSheet(
          useSafeArea: true,
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: getWidth(context, 0.03),
                vertical: getWidth(context, 0.02),
              ),
              width: getAllWidth(context),
              height: Responsive.isTablet(context) ? 250 : 200,
              child: BlocProvider(
                create: (context) => AuthBloc(AuthRepository()),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthErrorState) {
                      Navigator.pop(context);
                      getSnackBarWidget(
                          context, state.errorMessage.errorMsg!, Colors.red);
                    }
                    if (state is LogOutCompletedState) {
                      Navigator.pop(context);

                      Navigator.pushNamedAndRemoveUntil(
                          context, SplashScreen.screenId, (route) => false);
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'خروج از حساب کاربری',
                          style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          'آیا میخواهید از حساب کاربری خود خارج شوید؟!',
                          style: TextStyle(
                            fontFamily: 'normal',
                            fontSize: 16.sp,
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 0.03)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    fixedSize: Size(
                                      getWidth(context, 0.4),
                                      Responsive.isTablet(context) ? 60 : 45,
                                    ),
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<AuthBloc>(context)
                                        .add(CallLogOutEvent());
                                  },
                                  child: Text(
                                    'خروج از حساب',
                                    style: TextStyle(
                                      fontFamily: 'normal',
                                      fontSize: 16.sp,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(
                                      getWidth(context, 0.4),
                                      Responsive.isTablet(context) ? 60 : 45,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'برگشت',
                                    style: TextStyle(
                                      fontFamily: 'bold',
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class AboutUsWidget extends StatelessWidget {
  const AboutUsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'درباره ما',
        style: TextStyle(fontFamily: 'bold', fontSize: 16.sp),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () {
        showModalBottomSheet(
          useSafeArea: true,
          context: context,
          builder: (context) {
            final String desc =
                'گروه نرم افزاری پروگرمینگ شو با هدف عدالت اموزشی ، فعالیت خود را از سال 1400 آغاز کرده تا همه عزیزان ایران زمین بتوانند با خیال راحت اموزش هایی متناسب با علاقه و توانایی هایشان را در بر بگیرند';
            return Container(
              width: getAllWidth(context),
              height: Responsive.isTablet(context) ? 300 : 250,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 15.sp, horizontal: 10.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'نرم افزار اموزشی پروگرمینگ شو',
                      style: TextStyle(
                        fontFamily: 'bold',
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      'ایران - مازندران',
                      style: TextStyle(
                        fontFamily: 'normal',
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      desc,
                      style: TextStyle(fontFamily: 'normal', fontSize: 12.sp),
                    ),
                    TextButton(
                      onPressed: () {
                        final Uri smsLaunchUri = Uri(
                          scheme: 'tel',
                          path: '09050369171',
                          // queryParameters: <String, String>{
                          //   'body': Uri.encodeComponent('Example Subject & Symbols are allowed!'),
                          // },
                        );

                        launchUrl(smsLaunchUri);
                      },
                      child: const Text('09050369171'),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(getWidth(context, 0.4),
                                Responsive.isTablet(context) ? 60 : 45)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'بازگشت',
                          style: TextStyle(fontFamily: 'bold'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
