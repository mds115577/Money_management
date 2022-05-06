import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Income_Expense extends StatelessWidget {
  final String? label;
  final String? amount;
  final Color? color;
  final Color? shadow;
  const Income_Expense(
      {Key? key, this.label, this.amount, this.color, this.shadow})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 100,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        color: color,
        elevation: 20,
        shadowColor: shadow,
        child: Wrap(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$label: ',
              style: GoogleFonts.inconsolata(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 38.0),
            child: Text(
              '$amount/-',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )
        ]),
      ),
    );
  }
}