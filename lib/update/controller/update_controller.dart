import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_1_money_management/db/transaction_db.dart';
import 'package:project_1_money_management/models/category_model.dart';
import 'package:project_1_money_management/screens/home/home_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../models/transactions_model.dart';

class UpdateController extends GetxController {
  final TransactionDbFunctions _cont = Get.put(TransactionDbFunctions());
  Object? newId;
  Object? newId2;
  String? purposecontroller;
  String? amountcontroller;
  DateTime? date;
  CategoryType? type;
  DateTime? selected = DateTime.now();
  CategoryModel? cat;
  CategoryModel? cat2;
  updatefunct(BuildContext context, String id, String amt) async {
    final _update = TransactionModel(
      amount: double.tryParse(amt)!,
      purpose: purposecontroller!,
      category: cat!,
      date: date!,
      type: type,
      id: id,
    );

    await _cont.updateTransact(_update);
    cat = null;
    cat2 = null;
    newId = null;
    newId2 = null;
    showTopSnackBar(
      context,
      const CustomSnackBar.success(
        message: "Date Updated Succesfully",
      ),
    );
    await Get.off(ScreenHomes());
  }

  selectDates(BuildContext context) async {
    selected = await showDatePicker(
      context: context,
      initialDate: date!,
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != date!) {
      date = selected!;
    }
    update();
  }

  newone(CategoryModel e) {
    cat = e;
    update();
  }

  newteo(CategoryModel e) {
    cat2 = e;
    update();
  }

  onChangedcat(Object? value) {
    newId = value;
    update();
  }

  onChangedcatexpense(Object? value) {
    newId2 = value;
    update();
  }
}
