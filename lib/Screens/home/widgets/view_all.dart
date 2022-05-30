import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_1_money_management/view/view_data.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../db/transaction_db.dart';
import '../../../models/category_model.dart';
import '../../../models/transactions_model.dart';
import '../../../update/update.dart';

class ViewAll extends StatefulWidget {
  const ViewAll({Key? key}) : super(key: key);

  @override
  State<ViewAll> createState() => _ViewAllState();
}

TransactionModel? dat;
DateTimeRange? selecteds;
DateTime newsel = DateTime.now();
DateTime startDate = DateTime.now().add(const Duration(days: -5));
DateTime endDate = DateTime.now();
DateTimeRange? range;

class _ViewAllState extends State<ViewAll> {
  List<String> items = ['All', 'Today', 'Yesterday', 'Month', 'Custom'];
  @override
  void initState() {
    super.initState();
  }

  String dropdownValue = 'All';
  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(08.0),
                  child: Text(
                    'All Transactions: ',
                    style: GoogleFonts.inconsolata(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 40,
                  child: Card(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      onChanged: (String? value) async {
                        setState(
                          () {
                            dropdownValue = value!;
                            dropdownValue == 'Custom'
                                ? _selectDate(context)
                                : TransactionDB.instance
                                    .filterList(dropdownValue);
                          },
                        );
                      },
                      items: items.map<DropdownMenuItem<String>>((items) {
                        return DropdownMenuItem(
                          child: Text(items),
                          value: items,
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            // Visibility(
            //     visible: dropdownValue == 'This Year' ? true : false,
            //     child: const MonthChips()),
            const SizedBox(height: 10),
            ValueListenableBuilder(
                valueListenable: dropdownValue == 'All'
                    ? TransactionDB.instance.transactionListNotifier
                    : TransactionDB.instance.filterListNotifier,
                builder: (BuildContext context, List<TransactionModel> newList,
                    Widget? _) {
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index) {
                        final value = newList[index];
                        return Slidable(
                          key: Key(value.id!),
                          startActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  spacing: 6,
                                  backgroundColor: Colors.red,
                                  onPressed: (ctx) {
                                    setState(() {
                                      TransactionDB.instance
                                          .deleteTransactions(value.id!);
                                      showTopSnackBar(
                                        context,
                                        const CustomSnackBar.error(
                                          message: "Data Deleted Succesfully",
                                        ),
                                      );
                                    });
                                  },
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                                SlidableAction(
                                  spacing: 6,
                                  backgroundColor:
                                      const Color.fromARGB(255, 28, 114, 158),
                                  onPressed: (ctx) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (route) => UpdateScreen(
                                                  value: value,
                                                )));
                                  },
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                              ]),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                onTap: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (route) => ViewScreen(
                                            value: value,
                                          )));
                                }),
                                leading: CircleAvatar(
                                    radius: 30,
                                    backgroundColor:
                                        value.type == CategoryType.income
                                            ? Colors.green
                                            : Colors.red,
                                    child: Text(
                                      parseDate(value.date),
                                      style: GoogleFonts.inconsolata(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    )),
                                title: Text(
                                  '${value.amount}',
                                  style: GoogleFonts.inconsolata(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  value.category.name,
                                  style: GoogleFonts.inconsolata(
                                      fontWeight: FontWeight.w600),
                                ),
                                trailing: Wrap(
                                  children: [
                                    value.type == CategoryType.income
                                        ? Text(
                                            'Income',
                                            style: GoogleFonts.inconsolata(
                                                color: const Color.fromARGB(
                                                    255, 31, 233, 38),
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Text(
                                            'Expense',
                                            style: GoogleFonts.inconsolata(
                                                color: const Color.fromARGB(
                                                    255, 255, 7, 7),
                                                fontWeight: FontWeight.bold),
                                          )
                                  ],
                                ),
                              )),
                        );
                      },
                      separatorBuilder: (BuildContext context, index) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                      itemCount: newList.length);
                })
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final _initialDate = DateTimeRange(
        start: DateTime.now().add(const Duration(days: -2)),
        end: DateTime.now());
    selecteds = (await showDateRangePicker(
      context: context,
      initialDateRange: range ?? _initialDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ));
    setState(() {
      if (selecteds == null) {
        return;
      } else {
        range = selecteds!;
        startDate = range!.start;
        endDate = range!.end;
      }
      TransactionDB.instance.sortedCustom(startDate, endDate);
      selecteds == null;
    });
  }

  String parseDate(DateTime date) {
    return DateFormat("dd\nMMM").format(date);
  }
}
