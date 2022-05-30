import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/Screens/Adding_items/Widgets/radio.dart';
import 'package:project_1_money_management/db/category_db.dart';

import '../../../models/category_model.dart';

Object? categoryID;
CategoryModel? selectedCategoryModel;

class CategoryRefactor extends StatefulWidget {
  const CategoryRefactor({Key? key}) : super(key: key);

  @override
  State<CategoryRefactor> createState() => _CategoryRefactorState();
}

class _CategoryRefactorState extends State<CategoryRefactor> {
  @override
  void initState() {
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isIncome,
      builder: (BuildContext context, bool isIncome, f) {
        return isIncome
            ? ValueListenableBuilder(
                valueListenable: CategoryDB().incomeCategoryList,
                builder:
                    (BuildContext context, List<CategoryModel> newList, f) {
                  return Container(
                    width: 140,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: DropdownButton(
                        value: categoryID,
                        focusColor: const Color.fromARGB(255, 0, 0, 0),

                        //elevation: 5,
                        style: GoogleFonts.inconsolata(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                        iconEnabledColor: Colors.black,
                        items: newList.map((e) {
                          return DropdownMenuItem<String>(
                            onTap: () {
                              selectedCategoryModel = e;
                            },
                            value: e.id,
                            child: Text(
                              e.name.toUpperCase(),
                              style:
                                  GoogleFonts.inconsolata(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        hint: const Text(
                          "Select Category",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
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
                valueListenable: CategoryDB().expenseCategoryList,
                builder:
                    (BuildContext context, List<CategoryModel> newList, f) {
                  return Container(
                    width: 140,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: DropdownButton(
                        value: categoryID,
                        focusColor: const Color.fromARGB(255, 0, 0, 0),

                        //elevation: 5,
                        style: GoogleFonts.inconsolata(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                        iconEnabledColor: Colors.black,
                        items: newList.map((e) {
                          return DropdownMenuItem<String>(
                            onTap: () {
                              selectedCategoryModel = e;
                            },
                            value: e.id,
                            child: Text(
                              e.name.toUpperCase(),
                              style:
                                  GoogleFonts.inconsolata(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        hint: const Text(
                          "Select Category",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
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
    );
  }
}
// ValueListenableBuilder(
//         valueListenable = CategoryDB().expenseCategoryList,
//         builder = (BuildContext context, List<CategoryModel> newList, f) {
//           return Container(
//             width: 140,
//             height: 35,
//             decoration: BoxDecoration(
//                 color: Colors.white, borderRadius: BorderRadius.circular(15)),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: DropdownButton(
//                 focusColor: const Color.fromARGB(255, 0, 0, 0),

//                 //elevation: 5,
//                 style: GoogleFonts.inconsolata(
//                     color: const Color.fromARGB(255, 0, 0, 0)),
//                 iconEnabledColor: Colors.black,
//                 items: newList.map((e) {
//                   return DropdownMenuItem<String>(
//                     value: e.id,
//                     child: Text(
//                       e.name,
//                       style: GoogleFonts.inconsolata(color: Colors.black),
//                     ),
//                   );
//                 }).toList(),
//                 hint: const Text(
//                   "Select Category",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500),
//                 ),
//                 onChanged: (value) {
//                   setState(() {});
//                 },
//               ),
//             ),
//           );
//         });