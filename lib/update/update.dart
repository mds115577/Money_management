import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/db/transaction_db.dart';
import 'package:project_1_money_management/models/category_model.dart';
import 'package:project_1_money_management/refactors/bottom_bar.dart';
import 'package:project_1_money_management/update/controller/update_controller.dart';

import '../db/category_db.dart';
import '../models/transactions_model.dart';

class UpdateScreen extends StatelessWidget {
  final TransactionModel value;
  UpdateScreen({Key? key, required this.value}) : super(key: key);

  final TransactionDbFunctions _cont = Get.put(TransactionDbFunctions());
  final CategoryController _catcont = Get.put(CategoryController());
  final UpdateController _updateController = Get.put(UpdateController());

  @override
  Widget build(BuildContext context) {
    _updateController.amountcontroller = value.amount.toString();
    _updateController.purposecontroller = value.purpose;
    _updateController.date = value.date;
    _updateController.cat = value.category;
    _updateController.type = value.type;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 32, 32),
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _updateController.cat = null;
                      _updateController.cat2 = null;
                      _updateController.newId = null;
                      _updateController.newId2 = null;
                      Get.offAll(ScreenNavigation());

                      _cont.refresh();
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
                              GetBuilder<UpdateController>(builder: (contexts) {
                                return SizedBox(
                                  height: 40,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: DropdownButton(
                                        value: _updateController.newId,
                                        focusColor:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        elevation: 5,
                                        style: GoogleFonts.inconsolata(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0)),
                                        iconEnabledColor: Colors.black,
                                        items: _updateController.type ==
                                                CategoryType.income
                                            ? _catcont.incomeCategoryList
                                                .map((e) {
                                                return DropdownMenuItem<String>(
                                                  onTap: () {
                                                    _updateController.newone(e);
                                                  },
                                                  value: e.id,
                                                  child: Text(
                                                    e.name.toUpperCase(),
                                                    style:
                                                        GoogleFonts.inconsolata(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                );
                                              }).toList()
                                            : _catcont.expenseCategoryList
                                                .map((e) {
                                                return DropdownMenuItem<String>(
                                                  onTap: () {
                                                    _updateController.newteo(e);
                                                  },
                                                  value: e.id,
                                                  child: Text(
                                                    e.name.toUpperCase(),
                                                    style:
                                                        GoogleFonts.inconsolata(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                );
                                              }).toList(),
                                        hint: Text(
                                          _updateController.cat!.name,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        onChanged: (value) {
                                          _updateController.onChangedcat(value);
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              const Spacer(),

                              //...........................Date....................//
                              GetBuilder<UpdateController>(
                                  builder: (contextww) {
                                return ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color.fromARGB(255, 255, 251,
                                        253), //change background color of button
                                    onPrimary: const Color.fromARGB(255, 56,
                                        120, 204), //change text color of button
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    elevation: 15.0,
                                  ),
                                  onPressed: () {
                                    _updateController.selectDates(context);
                                  },
                                  icon: const Icon(Icons.calendar_month),
                                  label: Text(
                                    '${_updateController.date!.day}/${_updateController.date!.month}/${_updateController.date!.year}',
                                  ),
                                );
                              }),
                            ],
                          )),
                      //...........................Forms....................//
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: ((value) {
                                _updateController.amountcontroller = value;
                              }),
                              decoration: InputDecoration(
                                label: Text(
                                  '${_updateController.amountcontroller}',
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
                                _updateController.purposecontroller = value;
                              }),
                              decoration: InputDecoration(
                                label: Text(
                                  '${_updateController.purposecontroller}',
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
                                await _updateController.updatefunct(
                                    context,
                                    value.id!,
                                    _updateController.amountcontroller!);
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
}
