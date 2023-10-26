import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/cart/page/carts.page.dart';
import 'package:mawad/src/modules/home/pages/home.page.dart';
import 'package:mawad/src/modules/profile/page/profile.page.dart';

import 'favorite/pages/favorite.page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final iconList = <String>[
    'assets/icon/home_unselected.png',
    'assets/icon/favorite_unselected.png',
    'assets/icon/box_unselected.png',
    'assets/icon/profile_unselected.png',
  ];
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: getPage(_bottomNavIndex),
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.ltr,
        child: AnimatedBottomNavigationBar.builder(
            itemCount: iconList.length,
            tabBuilder: (int index, bool isActive) {
              return Center(
                child: Image.asset(
                  isActive
                      ? iconList[index].replaceFirst('unselected', 'selected')
                      : iconList[index],
                  width: 24,
                  height: 24,
                  // color: isActive ? null : Theme.of(context).disabledColor,
                ),
              );
            },
            activeIndex: _bottomNavIndex,
            gapLocation: GapLocation.none,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
            onTap: (index) {
              if (index == 2) {
                Get.to(() => CartsPage());
                return;
              }
              setState(() => _bottomNavIndex = index);
            }),
      ),
    );
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return FavoritePage();
      default:
        return const ProfilePage();
    }
  }
}
