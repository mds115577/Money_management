import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/Screens/Home/Widgets/income_expense.dart';
import 'package:project_1_money_management/screens/home/controller/home_controller.dart';
import 'package:sizer/sizer.dart';

import '../../db/transaction_db.dart';
import 'Widgets/listing_cards.dart';
import 'Widgets/listtile.dart';

class ScreenHomes extends StatelessWidget {
  ScreenHomes({Key? key}) : super(key: key);
  final TransactionDbFunctions _cont = Get.put(TransactionDbFunctions());
  final HomeController _homecont = Get.put(HomeController());

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
                    '${_homecont.usernameEntered},'.toUpperCase(),
                    style: GoogleFonts.inconsolata(
                        fontSize: 30.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0),
              child: Obx(() {
                _homecont.totaldata(_cont.transactionListNotifier);
                return Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      ListCard(
                        balance: '${_homecont.totalBalance}',
                        height: height / 8,
                        width: 90.w,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Income_Expense(
                              label: 'Income',
                              amount: '${_homecont.totalIncome}',
                              color: Colors.green,
                              shadow: Colors.green,
                            ),
                            Income_Expense(
                              label: 'Expense',
                              amount: '${_homecont.totalExpense}',
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
}
