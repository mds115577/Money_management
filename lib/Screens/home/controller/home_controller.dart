import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_1_money_management/db/transaction_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/category_model.dart';
import '../../../models/transactions_model.dart';

class HomeController extends GetxController {
  final TransactionDbFunctions _cont = Get.put(TransactionDbFunctions());
  double totalBalance = 0;
  double totalExpense = 0;
  double totalIncome = 0;
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
  }

  String? usernameEntered;
  Future<void> getName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    usernameEntered = pref.getString('username');
    update();
  }

  String dropdownValue = 'All';
  DateTimeRange? selecteds;
  DateTime newsel = DateTime.now();
  DateTime startDate = DateTime.now().add(const Duration(days: -5));
  DateTime endDate = DateTime.now();
  DateTimeRange? newRange;
  selectDate(BuildContext context) async {
    final _initialDate = DateTimeRange(
        start: DateTime.now().add(const Duration(days: -2)),
        end: DateTime.now());
    selecteds = (await showDateRangePicker(
      context: context,
      initialDateRange: newRange ?? _initialDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ));

    if (selecteds == null) {
      return;
    } else {
      newRange = selecteds!;
      startDate = newRange!.start;
      endDate = newRange!.end;
    }
    _cont.sortedCustom(startDate, endDate);
    selecteds == null;
    update();
  }

  dropdownhome(BuildContext context, String? value) {
    dropdownValue = value!;
    dropdownValue == 'Custom'
        ? selectDate(context)
        : _cont.filterList(dropdownValue);
    update();
  }
}
