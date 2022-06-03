import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/Screens/Adding_items/add_items.dart';
import 'package:project_1_money_management/Screens/Category/Widgets/category_radio_button.dart';
import 'package:project_1_money_management/db/category_db.dart';

import '../../../models/category_model.dart';

ValueNotifier<bool> isIncome = ValueNotifier(true);
CategoryType selectedType = CategoryType.income;

class RadioButton extends StatelessWidget {
  @override
  const RadioButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
      valueListenable: selectedCategory,
      builder: (BuildContext context, CategoryType newCategory, Widget? _) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: width / 2.6,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Radio<CategoryType>(
                          value: CategoryType.income,
                          groupValue: newCategory,
                          onChanged: (value) {
                            selectedCategory.value = value!;
                            // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                            selectedCategory.notifyListeners();
                            isIncome.value = true;
                            // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                            isIncome.notifyListeners();
                            categoryID = null;
                            newCategory = CategoryType.income;
                            selectedType = newCategory;
                            CategoryDB.instance.refreshUI();
                          },
                          activeColor: Colors.green,
                        ),
                        AutoSizeText(
                          'Income',
                          style: GoogleFonts.inconsolata(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: width / 2.6,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Radio<CategoryType>(
                          activeColor: Colors.green,
                          value: CategoryType.expense,
                          groupValue: newCategory,
                          onChanged: (value) {
                            selectedCategory.value = value!;
                            // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                            selectedCategory.notifyListeners();
                            isIncome.value = false;
                            // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                            isIncome.notifyListeners();
                            categoryID = null;
                            newCategory = CategoryType.expense;
                            selectedType = newCategory;
                            CategoryDB.instance.refreshUI();
                          },
                        ),
                        AutoSizeText(
                          'Expense',
                          style: GoogleFonts.inconsolata(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
