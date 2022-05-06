import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/Refactors/Home/date_picker.dart';
import 'package:project_1_money_management/Refactors/Add/category.dart';
import 'package:project_1_money_management/Refactors/Add/radio.dart';

class AddItems extends StatefulWidget {
  AddItems({Key? key}) : super(key: key);

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 32, 32),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add Transactions',
                style: GoogleFonts.inconsolata(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Card(
              color: Color.fromARGB(48, 175, 171, 171),
              elevation: 60,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  RadioButton(),
                  SizedBox(
                    height: 10,
                  ),
                  DatePick(),
                  SizedBox(
                    height: 19,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Row(
                      children: [
                        CategoryRefactor(),
                        Spacer(),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 251,
                                253), //change background color of button
                            onPrimary: Color.fromARGB(
                                255, 2, 2, 2), //change text color of button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 0.0,
                          ),
                          onPressed: () {},
                          icon: Icon(Icons.add),
                          label: Text(
                            'Add Category',
                            style: GoogleFonts.inconsolata(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
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
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 40.0, horizontal: 10.0),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: ('  Notes'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
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
                            primary: Color.fromARGB(255, 247, 247, 247),
                            textStyle: GoogleFonts.inconsolata(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('     Add     '),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
