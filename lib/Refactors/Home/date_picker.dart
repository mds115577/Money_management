import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DatePick extends StatefulWidget {
  const DatePick({Key? key}) : super(key: key);

  @override
  State<DatePick> createState() => _DatePickState();
}

class _DatePickState extends State<DatePick> {
  DateTime selectedDate = DateTime.now();
  String cdate = DateFormat("dd-MM-yyyy").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(
                  255, 255, 251, 253), //change background color of button
              onPrimary: Color.fromARGB(
                  255, 56, 120, 204), //change text color of button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 15.0,
            ),
            onPressed: () {
              _selectDate(context);
            },
            icon: Icon(Icons.calendar_month),
            label: Text(
                '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}\nChoose Date'))
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2023),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }
}
