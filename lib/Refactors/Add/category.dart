import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryRefactor extends StatefulWidget {
  const CategoryRefactor({Key? key}) : super(key: key);

  @override
  State<CategoryRefactor> createState() => _CategoryRefactorState();
}

class _CategoryRefactorState extends State<CategoryRefactor> {
  @override
  String? _chosenValue;
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: 140,
        height: 35,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: DropdownButton<String>(
            focusColor: Color.fromARGB(255, 0, 0, 0),
            value: _chosenValue,
            //elevation: 5,
            style: GoogleFonts.inconsolata(color: Color.fromARGB(255, 0, 0, 0)),
            iconEnabledColor: Colors.black,
            items: <String>[
              'Sales',
              'Salary',
              'Fashion',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: GoogleFonts.inconsolata(color: Colors.black),
                ),
              );
            }).toList(),
            hint: Text(
              "Select Category",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            onChanged: (value) {
              setState(() {
                _chosenValue = value!;
              });
            },
          ),
        ),
      ),
    );
  }
}
