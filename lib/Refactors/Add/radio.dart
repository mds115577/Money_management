import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RadioButton extends StatefulWidget {
  @override
  RadioButton({
    Key? key,
  }) : super(key: key);

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  bool _value = false;

  Object? val = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 150,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                    Text(
                      'Income',
                      style: GoogleFonts.inconsolata(fontSize: 20),
                    )
                  ],
                ),
              ),
              Spacer(),
              Container(
                width: 150,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                    Text(
                      'Expense',
                      style: GoogleFonts.inconsolata(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
