import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_prokala/const/theme/theme.dart';
import 'package:flutter_prokala/features/home_features/logic/bloc/home_bloc.dart';
import 'package:flutter_prokala/features/home_features/services/home_respository.dart';
import 'package:flutter_prokala/features/intro_features/logic/intro_cubit.dart';
import 'package:flutter_prokala/features/intro_features/screens/splash_screen.dart';
import 'package:flutter_prokala/features/public_features/logic/bottom_nav_cubit.dart';
import 'package:flutter_prokala/features/public_features/screens/unknownrout_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/authentication_features/screen/auth_screen.dart';
import 'features/category_features/screen/all_category_screen.dart';
import 'features/category_features/screen/category_screen.dart';
import 'features/comment_features/screen/add_comment_screen.dart';
import 'features/comment_features/screen/show_comment_screen.dart';
import 'features/favorite_features/screen/favorite_screen.dart';
import 'features/home_features/screens/home_screen.dart';
import 'features/intro_features/screens/intro_screen.dart';
import 'features/product_feature/screen/product_detail_screen.dart';
import 'features/profile_features/screen/check_profile.dart';
import 'features/public_features/logic/token_check/token_check_cubit.dart';
import 'features/public_features/screens/bottom_nav_bar.dart';
import 'features/search_feature/screen/search_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => IntroCubit()),
          BlocProvider(create: (context) => TokenCheckCubit()),
          // BlocProvider(create: (context) => HomeCubit()),
          BlocProvider(create: (context) => BottomNavCubit()),
          BlocProvider(create: (context) => HomeBloc(HomeRepository())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('fa')],
          theme: CustomTheme.lightTheme,
          // home: SplashScreen(),

          initialRoute: SplashScreen.screenId,
          onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (context) => const UnKnowRoutScreen(),
          ),
          routes: {
            SplashScreen.screenId: (context) => const SplashScreen(),
            IntroScreen.screenId: (context) => const IntroScreen(),
            HomeScreen.screenId: (context) => const HomeScreen(),
            BottomNavBarScreen.screenId: (context) => const BottomNavBarScreen(),
            CategoryScreen.screenId: (context) => const CategoryScreen(),
            AuthScreen.screenId: (context) => const AuthScreen(),
            ProductDetailScreen.screenId: (context) => const ProductDetailScreen(),
            ShowCommentScreen.screenId: (context) => const ShowCommentScreen(),
            AddCommentScreen.screenId: (context) => const AddCommentScreen(),
            AllCategoryScreen.screenId: (context) => const AllCategoryScreen(),
            SearchScreen.screenId: (context) => const SearchScreen(),
            CheckProfile.screenId: (context) => const CheckProfile(),
            FavoriteScreen.screenId: (context) => const FavoriteScreen(),
          },
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
