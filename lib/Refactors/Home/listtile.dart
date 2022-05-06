import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'date_picker.dart';

class ListItems extends StatelessWidget {
  ListItems({Key? key}) : super(key: key);

  @override
  String cdate = DateFormat("dd\nMMM").format(DateTime.now());
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(08.0),
                child: Text(
                  'Transactions: ',
                  style: GoogleFonts.inconsolata(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
              Spacer(),
            ],
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Color.fromARGB(255, 29, 27, 27),
                          child: Text(
                            cdate,
                            style: GoogleFonts.inconsolata(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )),
                      title: Text(
                        '12000/-',
                        style: GoogleFonts.inconsolata(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        'salary',
                        style: GoogleFonts.inconsolata(
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        'Income',
                        style: GoogleFonts.inconsolata(
                            color: Color.fromARGB(255, 62, 172, 66)),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, index) {
                  return SizedBox(
                    height: 5,
                  );
                },
                itemCount: 10),
          ),
        ],
      ),
    );
  }
}
