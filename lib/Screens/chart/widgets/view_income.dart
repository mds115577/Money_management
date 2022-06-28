import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_1_money_management/refactors/bottom_bar.dart';
import 'package:project_1_money_management/screens/chart/controller/chart_controller.dart';
import 'package:project_1_money_management/view/view_data.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../db/transaction_db.dart';
import '../../../models/category_model.dart';
import '../../../models/transactions_model.dart';
import '../../../update/update.dart';

class ViewAllIncomes extends StatelessWidget {
  ViewAllIncomes({Key? key}) : super(key: key);

  RxList<TransactionModel> dummy = <TransactionModel>[].obs;
  TransactionModel? dat;
  final ChartController _chartController = Get.put(ChartController());

  final TransactionDbFunctions _cont = Get.put(TransactionDbFunctions());
  List<String> items = ['All', 'Today', 'Yesterday', 'Month', 'Custom'];

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    _cont.refresh();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (ctx) => ScreenNavigation()),
                          (route) => false);
                      _cont.refresh();
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white)),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(08.0),
                  child: Text(
                    'All Transactions: ',
                    style: GoogleFonts.inconsolata(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 40,
                  child: Card(
                    child: DropdownButton<String>(
                      value: _chartController.dropdownValue2,
                      onChanged: (String? value) async {
                        _chartController.dropDownIncome(context, value);
                      },
                      items: items.map<DropdownMenuItem<String>>((items) {
                        return DropdownMenuItem(
                          child: Text(items),
                          value: items,
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: height / 1.36,
              child: Obx(() {
                if (_chartController.dropdownValue2 == 'All') {
                  dummy = _cont.incometransactionListNotifier;
                } else {
                  dummy = _cont.incomeFilterlist;
                }
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      final value = dummy[index];
                      return Slidable(
                        key: Key(value.id!),
                        startActionPane:
                            ActionPane(motion: const DrawerMotion(), children: [
                          SlidableAction(
                            spacing: 6,
                            backgroundColor: Colors.red,
                            onPressed: (ctx) {
                              _chartController.dropdownValue2 = 'All';
                              _cont.deleteTransactions(value.id!);
                              showTopSnackBar(
                                context,
                                const CustomSnackBar.error(
                                  message: "Data Deleted Succesfully",
                                ),
                              );
                            },
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            spacing: 6,
                            backgroundColor:
                                const Color.fromARGB(255, 28, 114, 158),
                            onPressed: (ctx) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (route) => UpdateScreen(
                                        value: value,
                                      )));
                            },
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                        ]),
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              onTap: (() {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (route) => ViewScreen(
                                          value: value,
                                        )));
                              }),
                              leading: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      value.type == CategoryType.income
                                          ? Colors.green
                                          : Colors.red,
                                  child: Text(
                                    parseDate(value.date),
                                    style: GoogleFonts.inconsolata(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  )),
                              title: Text(
                                '${value.amount}',
                                style: GoogleFonts.inconsolata(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                value.category.name,
                                style: GoogleFonts.inconsolata(
                                    fontWeight: FontWeight.w600),
                              ),
                              trailing: Wrap(
                                children: [
                                  value.type == CategoryType.income
                                      ? Text(
                                          'Income',
                                          style: GoogleFonts.inconsolata(
                                              color: const Color.fromARGB(
                                                  255, 31, 233, 38),
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          'Expense',
                                          style: GoogleFonts.inconsolata(
                                              color: const Color.fromARGB(
                                                  255, 255, 7, 7),
                                              fontWeight: FontWeight.bold),
                                        )
                                ],
                              ),
                            )),
                      );
                    },
                    separatorBuilder: (BuildContext context, index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                    itemCount: dummy.length);
              }),
            )
          ],
        ),
      ),
    );
  }

  String parseDate(DateTime date) {
    return DateFormat("dd\nMMM").format(date);
  }
}
