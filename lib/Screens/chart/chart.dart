import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/Screens/Chart/widgets/expense_tile.dart';
import 'package:project_1_money_management/Screens/Chart/widgets/income_tile.dart';

class PieChart extends StatefulWidget {
  const PieChart({Key? key}) : super(key: key);

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart>
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
                'Overview ',
                style: GoogleFonts.inconsolata(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
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
              children: [
                IncomeTile(),
                ExpenseTile(),
              ],
            ))
          ],
        )));
  }
}
