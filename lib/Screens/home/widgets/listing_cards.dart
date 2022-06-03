import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListCard extends StatelessWidget {
  final String? balance;
  final double width;
  final double height;
  final Color color;

  const ListCard({
    Key? key,
    required this.balance,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        shadowColor: color,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 00.0),
              child: Text(
                'My Balance is',
                style: GoogleFonts.inconsolata(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            AutoSizeText(
              '₹$balance',
              style: GoogleFonts.inconsolata(
                  fontSize: width / 11,
                  color: Colors.green,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
