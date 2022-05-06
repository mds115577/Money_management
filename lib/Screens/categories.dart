import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/Refactors/expense_category.dart';
import 'package:project_1_money_management/Refactors/income_category.dart';

class AddCategory extends StatefulWidget {
  AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategory();
}

class _AddCategory extends State<AddCategory>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
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
              onPressed: () {},
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
            children: [IncomeCategory(), ExpenseCategory()],
          ))
        ],
      )),
    );
  }
}
// SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 16.0, top: 18),
//                 child: Text(
//                   'Categories: ',
//                   style: GoogleFonts.inconsolata(
//                       color: Colors.white,
//                       fontSize: 30,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.only(left: 210.0),
//                 child: ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     primary: Color.fromARGB(
//                         255, 255, 251, 253), //change background color of button
//                     onPrimary: Color.fromARGB(
//                         255, 2, 2, 2), //change text color of button
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     elevation: 0.0,
//                   ),
//                   onPressed: () {},
//                   icon: Icon(Icons.add),
//                   label: Text(
//                     'Add Category',
//                     style: GoogleFonts.inconsolata(),
//                   ),
//                 ),
//               ),
//               Container(
//                 // height: 50,
//                 width: MediaQuery.of(context).size.height,
//                 decoration: BoxDecoration(
//                     color: Colors.redAccent,
//                     borderRadius: BorderRadius.circular(5)),
//                 child: Expanded(
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(5),
//                         child: TabBar(
//                           unselectedLabelColor: Colors.white,
//                           labelColor: Colors.black,
//                           indicatorColor: Colors.white,
//                           indicatorWeight: 2,
//                           indicator: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           controller: tabController,
//                           tabs: [
//                             Tab(
//                               text: 'Tab 1',
//                             ),
//                             Tab(
//                               text: 'Tab 1',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: TabBarView(
//                   controller: tabController,
//                   children: [
//                     Tab(
//                       text: 'sdfsdf',
//                     ),
//                     Tab(
//                       text: 'sdf',
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),