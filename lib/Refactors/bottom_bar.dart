import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_1_money_management/Screens/Settings/Settings.dart';
import 'package:project_1_money_management/db/category_db.dart';
import 'package:project_1_money_management/screens/adding_items/add_items.dart';
import 'package:project_1_money_management/screens/category/view/categories.dart';

import 'package:project_1_money_management/screens/home/home_screen.dart';

import '../screens/chart/view/chart.dart';

class ScreenNavigation extends StatelessWidget {
  final CategoryController _cont = Get.put(CategoryController());
  ScreenNavigation({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedPageIndex = ValueNotifier(0);
  final _pages = [
    ScreenHomes(),
    const PieChart(),
    AddCategory(),
    const Settings()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          _cont.refreshUI();
          Get.off(AddItemsView());
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: ScreenNavigation.selectedPageIndex,
        builder: (BuildContext context, int updatedIndex, Widget? _) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: BottomNavigationBar(
                backgroundColor: const Color.fromARGB(255, 198, 192, 192),
                currentIndex: updatedIndex,
                onTap: ((newIndex) {
                  ScreenNavigation.selectedPageIndex.value = newIndex;
                }),
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.pie_chart_outline), label: 'Charts'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.category_outlined), label: 'Category'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Settings'),
                ]),
          );
        },
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedPageIndex,
          builder: (BuildContext context, int updatedIndex, Widget? _) {
            return _pages[updatedIndex];
          },
        ),
      ),
    );
  }
}
