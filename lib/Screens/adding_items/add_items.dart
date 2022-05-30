import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/Screens/Adding_items/Widgets/date_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../db/transaction_db.dart';
import '../../models/transactions_model.dart';
import '../Category/categories.dart';
import 'Widgets/category.dart';
import 'Widgets/radio.dart';

final purposeTextEditingController = TextEditingController();
final amountTextEditingController = TextEditingController();

class AddItems extends StatelessWidget {
  const AddItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 32, 32),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Text(
                'Add Transactions',
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
                      const RadioButton(),
                      const DatePick(),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            children: [
                              const CategoryRefactor(),
                              const Spacer(),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color.fromARGB(255, 255, 251,
                                      253), //change background color of button
                                  onPrimary: const Color.fromARGB(255, 2, 2,
                                      2), //change text color of button
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0.0,
                                ),
                                onPressed: () {
                                  showCategoryAddPop(context);
                                },
                                icon: const Icon(Icons.add),
                                label: Text(
                                  'Add Category',
                                  style: GoogleFonts.inconsolata(),
                                ),
                              ),
                            ],
                          )),
                      Form(
                          child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              maxLength: 7,
                              keyboardType: TextInputType.number,
                              controller: amountTextEditingController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: ('  Amount'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              maxLength: 50,
                              controller: purposeTextEditingController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 40.0, horizontal: 10.0),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: ('  Purpose'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
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
                                await addTransaction(context);
                              },
                              child: const Text('     Add     '),
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

  addTransaction(context) async {
    final purposeText = purposeTextEditingController.text;
    final amountText = amountTextEditingController.text;
    final parsedtext = double.tryParse(amountText);
    if (parsedtext == null) {
      return showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Please Enter the amount",
        ),
      );
    }

    if (categoryID == null) {
      return showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Please Select Category",
        ),
      );
    }
    if (selected == null) {
      return showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Please Select Type",
        ),
      );
    }

    final _model = TransactionModel(
      amount: parsedtext,
      purpose: purposeText,
      category: selectedCategoryModel!,
      date: selected!,
      type: selectedType,
      id: DateTime.now().microsecondsSinceEpoch.toString(),
    );
    await TransactionDB.instance.addTransaction(_model);
    purposeTextEditingController.clear();
    amountTextEditingController.clear();

    TransactionDB.instance.refresh();
    showTopSnackBar(
      context,
      const CustomSnackBar.success(
        message: "Date Entered Succesfully",
      ),
    );
    categoryID = null;
  }
}
//  final purposeText = purposeTextEditingController.text;
//     final amountText = amountTextEditingController.text;
//     double? parsedtext = double.tryParse(amountText);
//     if (parsedtext != null &&
//         selectedCategoryModel != null &&
//         selected != null) {
//       TransactionModel obj = TransactionModel(
//           amount: parsedtext,
//           purpose: purposeText,
//           category: selectedCategoryModel!,
//           date: selected!,
//           type: selectedType);

//       TransactionDB object = TransactionDB();
//       await object.addTransaction(obj);
//       purposeTextEditingController.clear();
//       amountTextEditingController.clear();
//       categoryID = null;

//       TransactionDB.instance.refresh();