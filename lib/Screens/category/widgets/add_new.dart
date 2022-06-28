import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/models/category_model.dart';
import 'package:project_1_money_management/screens/category/controller/category_controller.dart';

import 'category_radio_button.dart';

final nameEditingController = TextEditingController();

class AddNewCategory extends StatelessWidget {
  AddNewCategory({Key? key}) : super(key: key);
  final CategoryAddController _cont = Get.put(CategoryAddController());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 175, 171, 171),
        // leading: IconButton(
        //     onPressed: () {

        //     }
        //   ,
        //       icon: Icon(Icons.arrow_back)),
      ),
      backgroundColor: const Color.fromARGB(255, 175, 171, 171),
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: const Color.fromARGB(255, 120, 107, 107),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 320,
                  child: Column(
                    children: [
                      Text(
                        'New Category',
                        style: GoogleFonts.inconsolata(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Form(
                        child: TextFormField(
                          maxLength: 13,
                          key: formKey,
                          controller: nameEditingController,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: [
                            ElevatedButton(
                              // ignore: duplicate_ignore
                              onPressed: () async {
                                await _cont.categoryAddpop(context);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 35, 32, 32),
                                // Text Color
                              ),
                              child: const Text('Add'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
