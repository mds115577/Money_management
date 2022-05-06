import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/Refactors/Home/date_picker.dart';
import 'package:project_1_money_management/Refactors/income_expense.dart';
import 'package:project_1_money_management/Refactors/Home/listing_cards.dart';
import 'package:project_1_money_management/Refactors/Home/listtile.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 32, 32),
      body: SafeArea(
        child: Expanded(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 35, 32, 32),
                      Color.fromARGB(255, 0, 0, 0),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 20),
                      child: Center(
                        child: Text(
                          'Monitor Your Money',
                          style: GoogleFonts.inconsolata(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, right: 0),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 0, 0, 0),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 0, 0, 0),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const ListCard(
                              balance: '12000',
                              height: 80,
                              width: 310,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Income_Expense(
                                    label: 'Income',
                                    amount: '24000',
                                    color: Colors.green,
                                    shadow: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  const Income_Expense(
                                    label: 'Expense',
                                    amount: '12000',
                                    color: Color.fromARGB(255, 221, 78, 68),
                                    shadow: Colors.red,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListItems(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
