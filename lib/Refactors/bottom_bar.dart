import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:project_1_money_management/Screens/Settings/Settings.dart';
import 'package:project_1_money_management/Screens/Adding_items/add_items.dart';
import 'package:project_1_money_management/Screens/Category/categories.dart';
import 'package:project_1_money_management/Screens/Chart/chart.dart';
import 'package:project_1_money_management/Screens/Home/home_screen.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: const Color.fromARGB(
            255, 108, 108, 108), // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(1.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15,
        // ignore: prefer_const_literals_to_create_immutables
        screens: [
          const ScreenHome(),
          const PieChart(),
          const AddItems(),
          const AddCategory(),
          const Settings(),
        ], // Choose the nav bar style with this property.
      ),
    );
  }
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.home),
      title: ('Home'),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: const Color.fromARGB(255, 252, 252, 252),
    ),
    PersistentBottomNavBarItem(
      title: ("Chart"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      icon: const Icon(
        CupertinoIcons.chart_pie,
      ),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        CupertinoIcons.add,
        color: Colors.black,
      ),
      activeColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      title: ('Add'),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.list_bullet),
      inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      title: ('category'),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.settings),
      inactiveColorPrimary: const Color.fromARGB(255, 255, 255, 255),
      title: ('Settings'),
    ),
  ];
}
