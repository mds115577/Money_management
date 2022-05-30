import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_1_money_management/Screens/Chart/widgets/pie_chart_income.dart';
import 'package:project_1_money_management/db/transaction_db.dart';
import 'package:project_1_money_management/screens/chart/widgets/view_income.dart';

import '../../../models/transactions_model.dart';

// ignore: must_be_immutable
class IncomeTile extends StatelessWidget {
  IncomeTile({Key? key}) : super(key: key);

  String cdate = DateFormat("dd\nMMM").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: const [
            Expansewidget(),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(08.0),
              child: Text(
                'Transactions: ',
                style: GoogleFonts.inconsolata(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (route) => const ViewAllIncome()));
                  },
                  label: Text(
                    'View All',
                    style: GoogleFonts.inconsolata(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  icon: const Icon(
                    Icons.arrow_right_alt,
                    color: Colors.black,
                  )),
            ),
          ],
        ),
        ValueListenableBuilder(
          valueListenable: TransactionDB.instance.incometransactionListNotifier,
          builder:
              (BuildContext context, List<TransactionModel> lists, Widget? _) {
            return Expanded(
              child: ListView.separated(
                  itemBuilder: (BuildContext context, index) {
                    final value = lists[index];

                    return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.green,
                              child: Text(
                                parseDate(value.date),
                                style: GoogleFonts.inconsolata(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )),
                          title: Text(
                            '${value.amount}',
                            style: GoogleFonts.inconsolata(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            value.category.name,
                            style: GoogleFonts.inconsolata(
                                fontWeight: FontWeight.w600),
                          ),
                          trailing: Text(
                            'Income',
                            style: GoogleFonts.inconsolata(
                                color: const Color.fromARGB(255, 62, 172, 66)),
                          ),
                        ));
                  },
                  separatorBuilder: (BuildContext context, index) {
                    return const SizedBox(
                      height: 5,
                    );
                  },
                  itemCount: lists.length < 4 ? lists.length : 4),
            );
          },
        ),
      ],
    );
  }

  String parseDate(DateTime date) {
    return DateFormat("dd\nMMM").format(date);
  }
}
