import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/db/category_db.dart';
import 'package:project_1_money_management/screens/category/widgets/add_new.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ExpenseCategorys extends StatelessWidget {
  ExpenseCategorys({Key? key}) : super(key: key);
  final CategoryController _cont = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
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
                  Get.to(AddNewCategory());
                },
                icon: const Icon(Icons.add),
                label: AutoSizeText(
                  'Add Category',
                  maxLines: 2,
                  style: GoogleFonts.inconsolata(),
                ),
              ),
            ],
          ),
          Container(
            height: 460,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 175, 171, 171),
                borderRadius: BorderRadius.circular(20)),
            child: Obx(() {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                _cont.refreshUI();
              });
              return ListView.separated(
                  itemBuilder: (BuildContext context, index) {
                    final category = _cont.expenseCategoryList[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30, top: 8, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        height: 60,
                        child: ListTile(
                          title: Text(
                            category.name.toUpperCase(),
                            style: const TextStyle(
                                fontFamily: 'sans',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Expense',
                            style: GoogleFonts.inconsolata(
                                color: const Color.fromARGB(255, 172, 62, 62)),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                _cont.deleteCategory(category.id);
                                showTopSnackBar(
                                  context,
                                  const CustomSnackBar.error(
                                    message: "Category Deleted Succesfully",
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 218, 79, 69),
                              )),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, index) {
                    return const SizedBox(
                      height: 5,
                    );
                  },
                  itemCount: _cont.expenseCategoryList.length);
            }),
          ),
        ],
      ),
    );
  }
}
