import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/Screens/Category/Widgets/expense_category.dart';
import 'package:project_1_money_management/Screens/Category/Widgets/income_category.dart';

class AddCategory extends StatelessWidget {
  AddCategory({Key? key}) : super(key: key);
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Income'),
    const Tab(text: 'Expense'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 35, 32, 32),
        appBar: AppBar(
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
        body: TabBarView(children: [IncomeCategory(), ExpenseCategorys()]),
      ),
    );
  }
}
