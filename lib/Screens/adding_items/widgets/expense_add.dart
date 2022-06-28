import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:project_1_money_management/db/category_db.dart';
import 'package:project_1_money_management/db/transaction_db.dart';
import 'package:project_1_money_management/models/category_model.dart';
import 'package:project_1_money_management/screens/adding_items/controller/add_item_controller.dart';
import 'package:project_1_money_management/screens/category/view/categories.dart';

CategoryModel? selectedCategoryModel2;

class ExpenseAdd extends StatelessWidget {
  ExpenseAdd({Key? key}) : super(key: key);
  final AddItemController _addcont = Get.put(AddItemController());
  final TransactionDbFunctions _cont = Get.put(TransactionDbFunctions());
  final CategoryController _catcont = Get.put(CategoryController());
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
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Add Expense',
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
                      Column(
                        children: [
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: const Color.fromARGB(255, 255, 251,
                                    253), //change background color of button
                                onPrimary: const Color.fromARGB(255, 56, 120,
                                    204), //change text color of button
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 15.0,
                              ),
                              onPressed: () {
                                _addcont.selectDate(context);
                              },
                              icon: const Icon(Icons.calendar_month),
                              label: GetBuilder<AddItemController>(
                                  builder: (controller) {
                                return Text(
                                    '${_addcont.selectedDate.day}/${_addcont.selectedDate.month}/${_addcont.selectedDate.year}');
                              }))
                        ],
                      ),
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
                              Container(
                                width: width / 2.4,
                                height: 38,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GetBuilder<AddItemController>(
                                      builder: (c) {
                                    return DropdownButton(
                                        hint: Text(
                                          'Select Category',
                                          style: GoogleFonts.inconsolata(),
                                        ),
                                        value: categoryId2,
                                        items: _catcont.expenseCategoryList
                                            .map((e) {
                                          return DropdownMenuItem<String>(
                                            onTap: () {
                                              _addcont.newTwo(e);
                                            },
                                            value: e.id,
                                            child: Text(e.name),
                                          );
                                        }).toList(),
                                        onChanged: (selectedValue) {
                                          _addcont.changeModel2(selectedValue);
                                        });
                                  }),
                                ),
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
                                    Get.to(AddCategory());
                                  },
                                  icon: const Icon(Icons.add),
                                  label: AutoSizeText(
                                    'Add Category',
                                    style:
                                        GoogleFonts.inconsolata(fontSize: 20),
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
                                await _addcont.addTransactionExpense(context);
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
}