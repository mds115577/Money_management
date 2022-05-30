import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/models/transactions_model.dart';

class ViewScreen extends StatelessWidget {
  final TransactionModel value;

  const ViewScreen({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime _date = value.date;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 32, 32),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 40),
              child: Card(
                color: const Color.fromARGB(255, 213, 208, 208),
                elevation: 60,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, bottom: 40, left: 20, right: 10),
                  child: Column(
                    children: [
                      Text(
                        'Details',
                        style: GoogleFonts.inconsolata(
                            color: const Color.fromARGB(233, 26, 15, 15),
                            fontSize: 45,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'Amount:',
                            style: GoogleFonts.inconsolata(
                                color: const Color.fromARGB(233, 77, 64, 64),
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          const Spacer(),
                          Text(
                            '${value.amount}',
                            style: GoogleFonts.inconsolata(
                                fontSize: 35,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        children: [
                          Text(
                            'Date:',
                            style: GoogleFonts.inconsolata(
                                color: const Color.fromARGB(233, 77, 64, 64),
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          const Spacer(),
                          Text(
                            '${_date.day}/${_date.month}/${_date.year}',
                            style: GoogleFonts.inconsolata(
                                fontSize: 30, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        children: [
                          Text(
                            'Category:',
                            style: GoogleFonts.inconsolata(
                                color: const Color.fromARGB(233, 77, 64, 64),
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          const Spacer(),
                          Text(
                            value.category.name,
                            style: GoogleFonts.inconsolata(
                                fontSize: 30, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            children: [
                              Text(
                                'Purpose:',
                                style: GoogleFonts.inconsolata(
                                    color:
                                        const Color.fromARGB(233, 77, 64, 64),
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(),
                              Padding(
                                padding: const EdgeInsets.only(left: 148.0),
                                child: Text(
                                  value.purpose,
                                  style: GoogleFonts.inconsolata(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
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
