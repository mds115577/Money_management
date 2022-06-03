import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

// ignore: camel_case_types
class Income_Expense extends StatelessWidget {
  final String? label;
  final String? amount;
  final Color? color;
  final Color? shadow;
  const Income_Expense(
      {Key? key, this.label, required this.amount, this.color, this.shadow})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44.w,
      height: 13.h,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        color: color,
        elevation: 20,
        shadowColor: shadow,
        child: Wrap(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              '$label: ',
              maxLines: 1,
              style: GoogleFonts.inconsolata(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 38.0, right: 1),
            child: AutoSizeText(
              '$amount/-',
              maxLines: 1,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )
        ]),
      ),
    );
  }
}
