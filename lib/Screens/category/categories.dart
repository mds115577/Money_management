// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/Screens/Category/Widgets/expense_category.dart';
import 'package:project_1_money_management/Screens/Category/Widgets/income_category.dart';
import 'package:project_1_money_management/db/category_db.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../models/category_model.dart';
import 'Widgets/category_radio_button.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategory();
}

class _AddCategory extends State<AddCategory>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 32, 32),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 18),
            child: Text(
              'Categories: ',
              style: GoogleFonts.inconsolata(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 210.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(
                    255, 255, 251, 253), //change background color of button
                onPrimary: const Color.fromARGB(
                    255, 2, 2, 2), //change text color of button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0.0,
              ),
              onPressed: () {
                showCategoryAddPop(context);
              },
              icon: const Icon(Icons.add),
              label: Text(
                'Add Category',
                style: GoogleFonts.inconsolata(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
              top: 10,
            ),
            child: TabBar(
              labelStyle: GoogleFonts.inconsolata(fontSize: 20),
              labelColor: Colors.white,
              controller: tabController,
              indicator: BoxDecoration(
                  color: const Color.fromARGB(255, 120, 107, 107),
                  borderRadius: BorderRadius.circular(10)),
              // ignore: prefer_const_literals_to_create_immutables
              tabs: [
                const Tab(
                  text: 'Income',
                ),
                const Tab(
                  text: 'Expense',
                )
              ],
            ),
          ),
          Expanded(
              child: TabBarView(
            controller: tabController,
            children: const [IncomeCategory(), ExpenseCategory()],
          ))
        ],
      )),
    );
  }
}

Future<void> showCategoryAddPop(BuildContext context) async {
  final _formKey = GlobalKey<FormState>();
  final _nameEditingController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(builder: (context, set) {
        return SimpleDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: const Color.fromARGB(255, 120, 107, 107),
          title: Text('Add Category',
              style: GoogleFonts.inconsolata(color: Colors.white)),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 65,
                child: Form(
                  child: TextFormField(
                    maxLength: 13,
                    key: _formKey,
                    controller: _nameEditingController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: ('  Category Name'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: const [
                Category_Radio(
                  name: 'Income',
                  type: CategoryType.income,
                  color: Color.fromARGB(255, 24, 237, 31),
                  activecolor: Color.fromARGB(255, 24, 237, 31),
                ),
                Category_Radio(
                  name: 'Expense',
                  type: CategoryType.expense,
                  color: Color.fromARGB(255, 237, 49, 24),
                  activecolor: Color.fromARGB(255, 237, 49, 24),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  // ignore: duplicate_ignore
                  onPressed: () async {
                    final type = selectedCategory.value;
                    final name = _nameEditingController.text.trim();
                    if (name.isEmpty) {
                      return showTopSnackBar(
                        context,
                        const CustomSnackBar.error(
                          message: "Please Enter the Category",
                        ),
                      );
                    }

                    final _category = CategoryModel(
                        id: DateTime.now().toString(), name: name, type: type);

                    await CategoryDB().insertCategory(_category);
                    // ignore: invalid_use_of_visible_for_testing_member,
                    CategoryDB().expenseCategoryList.notifyListeners();
                    // ignore: invalid_use_of_visible_for_testing_member,
                    CategoryDB().incomeCategoryList.notifyListeners();
                    // ignore: invalid_use_of_visible_for_testing_member
                    CategoryDB().allCategoryList.notifyListeners();
                    Navigator.of(ctx).pop();
                    showTopSnackBar(
                      context,
                      const CustomSnackBar.success(
                        message: "Category Created Successfully",
                      ),
                    );
                  },
                  child: const Text('Add'),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 35, 32, 32),
                    // Text Color
                  ),
                ),
              ],
            )
          ],
        );
      });
    },
  );
}
