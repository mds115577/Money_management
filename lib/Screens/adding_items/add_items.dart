import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/Screens/Adding_items/Widgets/date_picker.dart';
import 'package:project_1_money_management/refactors/bottom_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../db/category_db.dart';
import '../../db/transaction_db.dart';
import '../../models/category_model.dart';
import '../../models/transactions_model.dart';
import '../Category/categories.dart';
import '../category/Widgets/category_radio_button.dart';

ValueNotifier<bool> isIncome = ValueNotifier(true);
CategoryType selectedType = CategoryType.income;
final purposeTextEditingController = TextEditingController();
final amountTextEditingController = TextEditingController();
Object? categoryID;
CategoryModel? selectedCategoryModel;

class AddItems extends StatefulWidget {
  const AddItems({Key? key}) : super(key: key);

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  @override
  void initState() {
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 32, 32),
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (ctx) => ScreenNavigation()),
                          (route) => false);
                      TransactionDB.instance.refresh();
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Add Transactions',
                style: GoogleFonts.inconsolata(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Card(
                color: const Color.fromARGB(48, 175, 171, 171),
                elevation: 60,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40),
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: selectedCategory,
                        builder: (BuildContext context,
                            CategoryType newCategory, Widget? _) {
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: width / 2.6,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Radio<CategoryType>(
                                            value: CategoryType.income,
                                            groupValue: newCategory,
                                            onChanged: (value) {
                                              selectedCategory.value = value!;
                                              // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                                              selectedCategory
                                                  .notifyListeners();
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
                                            style: GoogleFonts.inconsolata(
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: width / 2.6,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Radio<CategoryType>(
                                            activeColor: Colors.green,
                                            value: CategoryType.expense,
                                            groupValue: newCategory,
                                            onChanged: (value) {
                                              selectedCategory.value = value!;
                                              // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                                              selectedCategory
                                                  .notifyListeners();
                                              isIncome.value = false;
                                              // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                                              isIncome.notifyListeners();
                                              categoryID = null;
                                              newCategory =
                                                  CategoryType.expense;
                                              selectedType = newCategory;
                                              CategoryDB.instance.refreshUI();
                                            },
                                          ),
                                          AutoSizeText(
                                            'Expense',
                                            style: GoogleFonts.inconsolata(
                                                fontSize: 20),
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
                      ),
                      const DatePick(),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            children: [
                              ValueListenableBuilder(
                                valueListenable: isIncome,
                                builder:
                                    (BuildContext context, bool isIncome, f) {
                                  return isIncome
                                      ? ValueListenableBuilder(
                                          valueListenable:
                                              CategoryDB().incomeCategoryList,
                                          builder: (BuildContext context,
                                              List<CategoryModel> newList, f) {
                                            return Container(
                                              width: width / 2.3,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: DropdownButton(
                                                  value: categoryID,
                                                  focusColor:
                                                      const Color.fromARGB(
                                                          255, 0, 0, 0),

                                                  //elevation: 5,
                                                  style:
                                                      GoogleFonts.inconsolata(
                                                          color: const Color
                                                                  .fromARGB(
                                                              255, 0, 0, 0)),
                                                  iconEnabledColor:
                                                      Colors.black,
                                                  items: newList.map((e) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      onTap: () {
                                                        selectedCategoryModel =
                                                            e;
                                                      },
                                                      value: e.id,
                                                      child: Text(
                                                        e.name.toUpperCase(),
                                                        style: GoogleFonts
                                                            .inconsolata(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  hint: AutoSizeText(
                                                    "Select Category",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      categoryID = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                            );
                                          })
                                      : ValueListenableBuilder(
                                          valueListenable:
                                              CategoryDB().expenseCategoryList,
                                          builder: (BuildContext context,
                                              List<CategoryModel> newList, f) {
                                            return Container(
                                              width: width / 2.3,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: DropdownButton(
                                                  value: categoryID,
                                                  focusColor:
                                                      const Color.fromARGB(
                                                          255, 0, 0, 0),

                                                  //elevation: 5,
                                                  style:
                                                      GoogleFonts.inconsolata(
                                                          color: const Color
                                                                  .fromARGB(
                                                              255, 0, 0, 0)),
                                                  iconEnabledColor:
                                                      Colors.black,
                                                  items: newList.map((e) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      onTap: () {
                                                        selectedCategoryModel =
                                                            e;
                                                      },
                                                      value: e.id,
                                                      child: Text(
                                                        e.name.toUpperCase(),
                                                        style: GoogleFonts
                                                            .inconsolata(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  hint: AutoSizeText(
                                                    "Select Category",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(
                                                      () {
                                                        categoryID = value;
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                },
                              ),
                              const Spacer(),
                              SizedBox(
                                width: width / 2.5,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color.fromARGB(255, 255, 251,
                                        253), //change background color of button
                                    onPrimary: const Color.fromARGB(255, 2, 2,
                                        2), //change text color of button
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 0.0,
                                  ),
                                  onPressed: () {
                                    showCategoryAddPop(context);
                                  },
                                  icon: const Icon(Icons.add),
                                  label: AutoSizeText(
                                    'Add Category',
                                    style: GoogleFonts.inconsolata(
                                        fontSize: 12.sp),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Form(
                          child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              controller: amountTextEditingController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: ('  Amount'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              maxLength: 50,
                              controller: purposeTextEditingController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 40.0, horizontal: 10.0),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: ('  Purpose'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(19),
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color.fromARGB(255, 81, 185, 67),
                                      Color.fromARGB(255, 32, 188, 32),
                                      Color.fromARGB(255, 52, 181, 32),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.only(),
                                primary:
                                    const Color.fromARGB(255, 247, 247, 247),
                                textStyle: GoogleFonts.inconsolata(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () async {
                                await addTransaction(context);
                              },
                              child: const Text('     Add     '),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addTransaction(context) async {
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

    if (categoryID == null) {
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

    final _model = TransactionModel(
      amount: parsedtext,
      purpose: purposeText,
      category: selectedCategoryModel!,
      date: selected!,
      type: selectedType,
      id: DateTime.now().microsecondsSinceEpoch.toString(),
    );
    await TransactionDB.instance.addTransaction(_model);
    purposeTextEditingController.clear();
    amountTextEditingController.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => ScreenNavigation()),
        (route) => false);
    TransactionDB.instance.refresh();
    showTopSnackBar(
      context,
      const CustomSnackBar.success(
        message: "Date Entered Succesfully",
      ),
    );
    categoryID = null;
  }
}
//  final purposeText = purposeTextEditingController.text;
//     final amountText = amountTextEditingController.text;
//     double? parsedtext = double.tryParse(amountText);
//     if (parsedtext != null &&
//         selectedCategoryModel != null &&
//         selected != null) {
//       TransactionModel obj = TransactionModel(
//           amount: parsedtext,
//           purpose: purposeText,
//           category: selectedCategoryModel!,
//           date: selected!,
//           type: selectedType);

//       TransactionDB object = TransactionDB();
//       await object.addTransaction(obj);
//       purposeTextEditingController.clear();
//       amountTextEditingController.clear();
//       categoryID = null;

//       TransactionDB.instance.refresh();