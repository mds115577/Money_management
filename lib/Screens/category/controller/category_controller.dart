import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_1_money_management/Screens/Category/Widgets/add_new.dart';
import 'package:project_1_money_management/Screens/Category/Widgets/category_radio_button.dart';
import 'package:project_1_money_management/db/category_db.dart';
import 'package:project_1_money_management/models/category_model.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CategoryAddController extends GetxController {
  final CategoryController _cont = Get.put(CategoryController());
  Future<void> categoryAddpop(BuildContext context) async {
    final type = selectedCategory.value;

    final name = nameEditingController.text.trim();
    if (name.isEmpty) {
      return showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Please Enter the Category",
        ),
      );
    }

    for (CategoryModel item in _cont.incomeCategoryList) {
      if (name == item.name) {
        return showTopSnackBar(
          context,
          const CustomSnackBar.error(
            message: "This is already entered",
          ),
        );
      }
    }
    for (CategoryModel item in _cont.expenseCategoryList) {
      if (name == item.name && type == CategoryType.expense) {
        return showTopSnackBar(
          context,
          const CustomSnackBar.error(
            message: "This is already entered",
          ),
        );
      }
    }
        
    final category =
        CategoryModel(id: DateTime.now().toString(), name: name, type: type);

    await _cont.insertCategory(category);
    showTopSnackBar(
      context,
      const CustomSnackBar.success(
        message: "Data Entered Succesfully",
      ),
    );

    nameEditingController.clear();
  }
}
