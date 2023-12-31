import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prokala/const/theme/colors.dart';
import 'package:flutter_prokala/features/public_features/logic/bottom_nav_cubit.dart';
import 'package:flutter_prokala/features/public_features/logic/token_check/token_check_cubit.dart';

import '../../cart_feature/screen/check_cart.dart';
import '../../category_features/screen/category_screen.dart';
import '../../home_features/screens/home_screen.dart';
import '../../profile_features/screen/check_profile.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  static const String screenId = '/bottomnav';

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  List<Widget> screenList = [
    const HomeScreen(),
    const CategoryScreen(),
    const CheckCart(),
    const CheckProfile(),
  ];

  @override
  void initState() {
    super.initState();

    BlocProvider.of<TokenCheckCubit>(context).tokenCheck();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        final bottomNavCubit = BlocProvider.of<BottomNavCubit>(context);
        return SafeArea(
          child: Scaffold(

            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: primaryColor,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              unselectedItemColor: theme.iconTheme.color,
              selectedLabelStyle: const TextStyle(fontFamily: 'bold'),
              unselectedLabelStyle: const TextStyle(fontFamily: 'bold'),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'صفحه اصلی',
                  activeIcon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined),
                  label: 'دسته ها',
                  activeIcon: Icon(Icons.category),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                  ),
                  label: 'سید خرید',
                  activeIcon: Icon(Icons.shopping_cart),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  label: 'پروفایل',
                  activeIcon: Icon(Icons.settings),
                ),
              ],
              currentIndex: bottomNavCubit.screenIndex,
              onTap: (value) {
                bottomNavCubit.onTap(value);
              },
            ),
            body: screenList.elementAt(bottomNavCubit.screenIndex),
          ),
        );
      },
    );
  }
}
