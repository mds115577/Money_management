// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:project_1_money_management/Screens/Adding_items/add_items.dart';
// import 'package:project_1_money_management/db/category_db.dart';
// import 'package:sizer/sizer.dart';

// import '../../../models/category_model.dart';
// import '../controller/add_item_controller.dart';

// class CategoryRefactor extends StatefulWidget {
//   const CategoryRefactor({Key? key}) : super(key: key);

//   @override
//   State<CategoryRefactor> createState() => _CategoryRefactorState();
// }

// class _CategoryRefactorState extends State<CategoryRefactor> {
//   @override
//   void initState() {
//     CategoryDB().refreshUI();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height, width;
//     height = MediaQuery.of(context).size.height;
//     width = MediaQuery.of(context).size.width;
//     return ValueListenableBuilder(
//       valueListenable: isIncome,
//       builder: (BuildContext context, bool isIncome, f) {
//         return isIncome
//             ? ValueListenableBuilder(
//                 valueListenable: CategoryDB().incomeCategoryList,
//                 builder:
//                     (BuildContext context, List<CategoryModel> newList, f) {
//                   return Container(
//                     width: width / 2.3,
//                     height: 35,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15)),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 8.0),
//                       child: DropdownButton(
//                         value: categoryID,
//                         focusColor: const Color.fromARGB(255, 0, 0, 0),

//                         //elevation: 5,
//                         style: GoogleFonts.inconsolata(
//                             color: const Color.fromARGB(255, 0, 0, 0)),
//                         iconEnabledColor: Colors.black,
//                         items: newList.map((e) {
//                           return DropdownMenuItem<String>(
//                             onTap: () {
//                               selectedCategoryModel = e;
//                             },
//                             value: e.id,
//                             child: Text(
//                               e.name.toUpperCase(),
//                               style:
//                                   GoogleFonts.inconsolata(color: Colors.black),
//                             ),
//                           );
//                         }).toList(),
//                         hint: AutoSizeText(
//                           "Select Category",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 13.sp,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         onChanged: (value) {
//                           setState(() {
//                             categoryID = value;
//                           });
//                         },
//                       ),
//                     ),
//                   );
//                 })
//             : ValueListenableBuilder(
//                 valueListenable: CategoryDB().expenseCategoryList,
//                 builder:
//                     (BuildContext context, List<CategoryModel> newList, f) {
//                   return Container(
//                     width: width / 2.3,
//                     height: 35,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15)),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 8.0),
//                       child: DropdownButton(
//                         value: categoryID,
//                         focusColor: const Color.fromARGB(255, 0, 0, 0),

//                         //elevation: 5,
//                         style: GoogleFonts.inconsolata(
//                             color: const Color.fromARGB(255, 0, 0, 0)),
//                         iconEnabledColor: Colors.black,
//                         items: newList.map((e) {
//                           return DropdownMenuItem<String>(
//                             onTap: () {
//                               selectedCategoryModel = e;
//                             },
//                             value: e.id,
//                             child: Text(
//                               e.name.toUpperCase(),
//                               style:
//                                   GoogleFonts.inconsolata(color: Colors.black),
//                             ),
//                           );
//                         }).toList(),
//                         hint: AutoSizeText(
//                           "Select Category",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 13.sp,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         onChanged: (value) {
//                           setState(
//                             () {
//                               categoryID = value;
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               );
//       },
//     );
//   }
// }
