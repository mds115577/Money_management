import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_1_money_management/Screens/Home/Widgets/view_all.dart';
import 'package:project_1_money_management/db/transaction_db.dart';
import 'package:project_1_money_management/models/category_model.dart';
import 'package:project_1_money_management/view/view_data.dart';
import 'package:sizer/sizer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../models/transactions_model.dart';
import '../../../update/update.dart';

// ignore: must_be_immutable
class ListItems extends StatefulWidget {
  ListItems({Key? key}) : super(key: key);
  Object? val;
  @override
  State<ListItems> createState() => _ListItemsState();
}

TransactionModel? dat;
DateTime? selecteds = DateTime.now();

class _ListItemsState extends State<ListItems> {
  List<String> items = ['All', 'Today', 'Yesterday', 'Month', 'Custom'];
  @override
  void initState() {
    super.initState();
  }

  String dropdownValue = 'All';
  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(08.0),
                child: Text(
                  'Recent-Transactions: ',
                  style: GoogleFonts.inconsolata(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Colors.white),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 34.w,
                height: 5.h,
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (route) => const ViewAll()));
                    },
                    label: AutoSizeText(
                      'View All',
                      style: GoogleFonts.inconsolata(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp),
                    ),
                    icon: const Icon(
                      Icons.arrow_right_alt,
                      color: Colors.black,
                    )),
              ),
              SizedBox(width: 2.w)

              // SizedBox(
              //   height: 40,
              //   child: Card(
              //     child: DropdownButton<String>(
              //       value: dropdownValue,
              //       onChanged: (String? value) async {
              //         setState(
              //           () {
              //             dropdownValue = value!;
              //             if (dropdownValue == 'Custom') {
              //               _selectDate(context);
              //             }
              //             TransactionDB.instance
              //                 .filterList(dropdownValue, selecteds!);
              //           },
              //         );
              //       },
              //       items: items.map<DropdownMenuItem<String>>((items) {
              //         return DropdownMenuItem(
              //           child: Text(items),
              //           value: items,
              //         );
              //       }).toList(),
              //     ),
              //   ),
              // )
            ],
          ),
          ValueListenableBuilder(
              valueListenable: TransactionDB.instance.transactionListNotifier,
              builder: (BuildContext context, List<TransactionModel> newList,
                  Widget? _) {
                return Expanded(
                  child: ListView.separated(
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
                                    TransactionDB.instance
                                        .deleteTransactions(value.id!);
                                    showTopSnackBar(
                                      context,
                                      const CustomSnackBar.error(
                                        message: "Data Deleted Succesfully",
                                      ),
                                    );
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
                                    radius: 8.w,
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
                                      fontSize: 17.sp,
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
                      itemCount: newList.length < 4 ? newList.length : 4),
                );
              })
        ],
      ),
    );
  }

  // ignore: unused_element
  _selectDate(BuildContext context) async {
    selecteds = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    );
  }

  String parseDate(DateTime date) {
    return DateFormat("dd\nMMM").format(date);
  }
}
