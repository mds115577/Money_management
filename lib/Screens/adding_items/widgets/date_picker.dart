// import 'package:flutter/material.dart';

// class DatePick extends StatefulWidget {
//   const DatePick({Key? key}) : super(key: key);

//   @override
//   State<DatePick> createState() => _DatePickState();
// }

// DateTime? selecte = DateTime.now();
// DateTime selectedDate = DateTime.now();

// class _DatePickState extends State<DatePick> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton.icon(
//             style: ElevatedButton.styleFrom(
//               primary: const Color.fromARGB(
//                   255, 255, 251, 253), //change background color of button
//               onPrimary: const Color.fromARGB(
//                   255, 56, 120, 204), //change text color of button
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 15.0,
//             ),
//             onPressed: () {
//               _selectDate(context);
//             },
//             icon: const Icon(Icons.calendar_month),
//             label: Text(
//                 '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'))
//       ],
//     );
//   }

//   _selectDate(BuildContext context) async {
//     selected = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2021),
//       lastDate: DateTime.now(),
//     );
//     if (selected != null && selected != selectedDate) {
//       setState(() {
//         selectedDate = selected!;
//       });
//     }
//   }
// }
