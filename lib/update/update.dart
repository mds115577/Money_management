import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/db/transaction_db.dart';
import 'package:project_1_money_management/models/category_model.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../Screens/Adding_items/Widgets/date_picker.dart';
import '../Screens/Adding_items/add_items.dart';
import '../db/category_db.dart';
import '../models/transactions_model.dart';

class UpdateScreen extends StatefulWidget {
  final TransactionModel value;
  const UpdateScreen({Key? key, required this.value}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  CategoryType? type;
  DateTime? _date;

  CategoryModel? cat;

  String? purposecontroller;
  String? amountcontroller;
  @override
  // ignore: must_call_super
  void initState() {
    CategoryDB().refreshUI();
    TransactionDB.instance.refresh();

    amountcontroller = widget.value.amount.toString();
    purposecontroller = widget.value.purpose;
    _date = widget.value.date;
    cat = widget.value.category;
    type = widget.value.type;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 32, 32),
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      TransactionDB.instance.refresh();
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10),
              child: Text(
                'Edit Transactions',
                style: GoogleFonts.inconsolata(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Card(
                color: const Color.fromARGB(48, 175, 171, 171),
                elevation: 60,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),

                      //...........................Category....................//
                      Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            children: [
                              ValueListenableBuilder(
                                  valueListenable: type == CategoryType.income
                                      ? CategoryDB().incomeCategoryList
                                      : CategoryDB().expenseCategoryList,
                                  builder: (BuildContext context,
                                      List<CategoryModel> newList, f) {
                                    return SizedBox(
                                      height: 40,
                                      child: Card(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: DropdownButton(
                                            value: categoryID,
                                            focusColor: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            elevation: 5,
                                            style: GoogleFonts.inconsolata(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0)),
                                            iconEnabledColor: Colors.black,
                                            items: newList.map((e) {
                                              return DropdownMenuItem<String>(
                                                onTap: () {
                                                  cat = e;
                                                },
                                                value: e.id,
                                                child: Text(
                                                  e.name.toUpperCase(),
                                                  style:
                                                      GoogleFonts.inconsolata(
                                                          color: Colors.black),
                                                ),
                                              );
                                            }).toList(),
                                            hint: Text(
                                              cat!.name,
                                              style: const TextStyle(
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
                                      ),
                                    );
                                  }),
                              const Spacer(),

                              //...........................Date....................//
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color.fromARGB(255, 255, 251,
                                      253), //change background color of button
                                  onPrimary: const Color.fromARGB(255, 56, 120,
                                      204), //change text color of button
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  elevation: 15.0,
                                ),
                                onPressed: () {
                                  selectDates(context);
                                },
                                icon: const Icon(Icons.calendar_month),
                                label: Text(
                                  '${_date!.day}/${_date!.month}/${_date!.year}',
                                ),
                              ),
                            ],
                          )),
                      //...........................Forms....................//
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: ((value) {
                                amountcontroller = value;
                              }),
                              decoration: InputDecoration(
                                label: Text(
                                  '$amountcontroller',
                                  style: GoogleFonts.inconsolata(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: ((value) {
                                purposecontroller = value;
                              }),
                              decoration: InputDecoration(
                                label: Text(
                                  '$purposecontroller',
                                  style: GoogleFonts.inconsolata(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 40.0, horizontal: 10.0),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      //...........................Button....................//
                      ClipRRect(
                        borderRadius: BorderRadius.circular(19),
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color.fromARGB(255, 81, 185, 67),
                                      Color.fromARGB(255, 32, 188, 32),
                                      Color.fromARGB(255, 52, 181, 32),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.only(),
                                primary:
                                    const Color.fromARGB(255, 247, 247, 247),
                                textStyle: GoogleFonts.inconsolata(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () async {
                                await update(
                                  widget.value.id!,
                                  amountcontroller!,
                                );
                              },
                              child: const Text('     Update     '),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 14,
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

  selectDates(BuildContext context) async {
    selected = await showDatePicker(
      context: context,
      initialDate: _date!,
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != _date!) {
      setState(() {
        _date = selected!;
      });
    }
  }

  update(String id, String amt) async {
    final _update = TransactionModel(
      amount: double.tryParse(amt)!,
      purpose: purposecontroller!,
      category: cat!,
      date: _date!,
      type: type,
      id: id,
    );

    await TransactionDB.instance.updateTransact(_update);

    showTopSnackBar(
      context,
      const CustomSnackBar.success(
        message: "Date Updated Succesfully",
      ),
    );
  }
}
