import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/Screens/Home/Widgets/income_expense.dart';
import 'package:project_1_money_management/models/category_model.dart';
import 'package:project_1_money_management/models/transactions_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../db/transaction_db.dart';
import 'Widgets/listing_cards.dart';
import 'Widgets/listtile.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  double totalBalance = 0;
  double totalExpense = 0;
  double totalIncome = 0;
  @override
  void initState() {
    getName();
    super.initState();
  }

  String? usernameEntered;
  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 34, 35),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  ' Welcome',
                  style: GoogleFonts.inconsolata(
                    fontSize: 35,
                    color: const Color.fromARGB(255, 190, 189, 189),
                  ),
                ),
                const SizedBox(width: 9),
                Text(
                  '$usernameEntered,'.toUpperCase(),
                  style: GoogleFonts.inconsolata(
                      fontSize: 30.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0),
              child: ValueListenableBuilder(
                  valueListenable:
                      TransactionDB.instance.transactionListNotifier,
                  builder: (BuildContext context, List<TransactionModel> listss,
                      Widget? _) {
                    totaldata(listss);
                    return Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          ListCard(
                            balance: '$totalBalance',
                            height: height / 8,
                            width: 90.w,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Income_Expense(
                                  label: 'Income',
                                  amount: '$totalIncome',
                                  color: Colors.green,
                                  shadow: Colors.green,
                                ),
                                Income_Expense(
                                  label: 'Expense',
                                  amount: '$totalExpense',
                                  color: const Color.fromARGB(255, 221, 78, 68),
                                  shadow: Colors.red,
                                ),
                              ],
                            ),
                          )
                        ]);
                  }),
            ),
            SizedBox(
              height: height * .03,
            ),
            ListItems(),
          ],
        ),
      ),
    );
  }

  Future<void> getName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    usernameEntered = pref.getString('username');
    setState(() {});
  }

  totaldata(List<TransactionModel> value) async {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;

    for (TransactionModel data in value) {
      if (data.category.type == CategoryType.income) {
        totalIncome = totalIncome + data.amount;
      }
      if (data.category.type == CategoryType.expense) {
        totalExpense = totalExpense + data.amount;
      }
    }
    totalBalance = totalIncome - totalExpense;
    if (totalBalance < 0) {
      totalBalance = 0;
    }
    print(totalBalance);
  }
}
