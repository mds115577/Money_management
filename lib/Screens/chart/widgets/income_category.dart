// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:project_1_money_management/db/category_db.dart';

// import '../../../models/category_model.dart';

// class IncomeCategory extends StatelessWidget {
//   const IncomeCategory({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         height: 100,
//         decoration: BoxDecoration(
//             color: const Color.fromARGB(255, 175, 171, 171),
//             borderRadius: BorderRadius.circular(20)),
//         child: Expanded(
//             child: ValueListenableBuilder(
//                 valueListenable: CategoryDB().incomeCategoryList,
//                 builder: (BuildContext context, List<CategoryModel> newList,
//                     Widget? _) {
//                   return ListView.separated(
//                       itemBuilder: (BuildContext context, index) {
//                         final category = newList[index];
//                         return Padding(
//                           padding: const EdgeInsets.only(
//                               left: 30.0, right: 30, top: 8, bottom: 8),
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10)),
//                             height: 60,
//                             child: ListTile(
//                               title: Text(
//                                 category.name.toUpperCase(),
//                                 style: const TextStyle(
//                                     fontFamily: 'sans',
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               subtitle: Text(
//                                 'Income',
//                                 style: GoogleFonts.inconsolata(
//                                   color: const Color.fromARGB(255, 62, 172, 66),
//                                 ),
//                               ),
//                               trailing: IconButton(
//                                   onPressed: () {
//                                     CategoryDB.instance
//                                         .deleteCategory(category.id);
//                                   },
//                                   icon: const Icon(
//                                     Icons.delete,
//                                     color: Color.fromARGB(255, 218, 79, 69),
//                                   )),
//                             ),
//                           ),
//                         );
//                       },
//                       separatorBuilder: (BuildContext context, index) {
//                         return const SizedBox(
//                           height: 5,
//                         );
//                       },
//                       itemCount: newList.length);
//                 })),
//       ),
//     );
//   }
// }
