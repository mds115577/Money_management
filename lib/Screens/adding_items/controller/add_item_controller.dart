import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_1_money_management/db/transaction_db.dart';
import 'package:project_1_money_management/screens/adding_items/widgets/expense_add.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../db/category_db.dart';
import '../../../models/category_model.dart';
import '../../../models/transactions_model.dart';
import '../../../refactors/bottom_bar.dart';

CategoryModel? selectedCategoryModel;
final purposeTextEditingController = TextEditingController();
final amountTextEditingController = TextEditingController();
final TransactionDbFunctions _cont = Get.put(TransactionDbFunctions());
final CategoryController _catcont = Get.put(CategoryController());
final AddItemController _addcont = Get.put(AddItemController());
Object? categoryID;
Object? categoryId2;
DateTime? selected = DateTime.now();
DateTime? selected2 = DateTime.now();
DateTime selectedDate = DateTime.now();

class AddItemController extends GetxController {
  final TransactionDbFunctions _cont = Get.put(TransactionDbFunctions());
  addTransactionExpense(context) async {
    final purposeText = purposeTextEditingController.text;
    final amountText = amountTextEditingController.text;
    final parsedtext = double.tryParse(amountText);
    if (parsedtext == null) {
      return showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Please Enter the amount",
        ),
      );
    }

    if (categoryId2 == null) {
      return showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Please Select Category",
        ),
      );
    }
    if (selected == null) {
      return showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Please Select Type",
        ),
      );
    }

    final model = TransactionModel(
      amount: parsedtext,
      purpose: purposeText,
      date: selected!,
      type: CategoryType.expense,
      category: selectedCategoryModel2!,
      id: DateTime.now().microsecondsSinceEpoch.toString(),
    );
    await _cont.addTransaction(model);
    purposeTextEditingController.clear();
    amountTextEditingController.clear();
    Get.offAll(ScreenNavigation());
    _cont.refresh();
    showTopSnackBar(
      context,
      const CustomSnackBar.success(
        message: "Date Entered Succesfully",
      ),
    );
    categoryId2 = null;
  }

  newTwo(CategoryModel e) {
    selectedCategoryModel2 = e;
    update();
  }

  changeModel2(dynamic value) {
    categoryId2 = value;
    update();
  }

  DateTime selectedDate = DateTime.now();
  selectDate(BuildContext context) async {
    selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    );
    if (selected == null) {
      selectedDate = DateTime.now();
    } else {
      selectedDate = selected!;
    }

    update();
  }

  DateTime selectedDate2 = DateTime.now();
  selectDate2(BuildContext context) async {
    selected2 = await showDatePicker(
      context: context,
      initialDate: selectedDate2,
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    );
    if (selected2 == null) {
      selectedDate2 = DateTime.now();
    } else {
      selectedDate2 = selected2!;
    }

    update();
  }

  addTransactionIncome(dynamic context) async {
    final purposeText = purposeTextEditingController.text;
    final amountText = amountTextEditingController.text;
    final parsedtext = double.tryParse(amountText);
    if (parsedtext == null) {
      return showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Please Enter the amount",
        ),
      );
    }

    // if (categoryID == null) {
    //   return showTopSnackBar(
    //     context,
    //     const CustomSnackBar.error(
    //       message: "Please Select Category",
    //     ),
    //   );
    // }
    if (selected == null) {
      return showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Please Select Type",
        ),
      );
    }

    final model = TransactionModel(
      amount: parsedtext,
      purpose: purposeText,
      category: selectedCategoryModel!,
      date: selected!,
      type: CategoryType.income,
      id: DateTime.now().microsecondsSinceEpoch.toString(),
    );
    await _cont.addTransaction(model);
    print("ADDED");
    purposeTextEditingController.clear();
    amountTextEditingController.clear();
    Get.offAll(ScreenNavigation());
    await _cont.refresh();
    showTopSnackBar(
      context,
      const CustomSnackBar.success(
        message: "Date Entered Succesfully",
      ),
    );
    categoryID = null;
  }

  newone(CategoryModel e) {
    selectedCategoryModel = e;
    update();
  }

  changeModel(dynamic value) {
    categoryID = value;
    update();
  }
}
