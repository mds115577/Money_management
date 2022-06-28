import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/models/category_model.dart';
import 'package:project_1_money_management/refactors/bottom_bar.dart';
import 'package:project_1_money_management/screens/adding_items/widgets/expense_add.dart';
import 'package:project_1_money_management/screens/adding_items/widgets/income_add.dart';

CategoryType selectedType = CategoryType.income;
final purposeTextEditingController = TextEditingController();
final amountTextEditingController = TextEditingController();
Object? categoryID;
Object? categoryId2;

class AddItemsView extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Income'),
    const Tab(text: 'Expense'),
  ];

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 35, 32, 32),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.offAll(ScreenNavigation());
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white)),
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 50.0, right: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end, children: const []),
          ),
          backgroundColor: const Color.fromARGB(255, 35, 32, 32),
          title: Center(
              child: Text('Categories:',
                  style: GoogleFonts.inconsolata(
                      fontSize: 30, fontWeight: FontWeight.bold))),
          bottom: TabBar(
            tabs: myTabs,
          ),
        ),
        body: TabBarView(children: [IncomeAdd(), ExpenseAdd()]),
      ),
    );
  }
}
