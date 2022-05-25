import 'package:flutter/material.dart';

int? month;

class MonthChips extends StatefulWidget {
  const MonthChips({Key? key}) : super(key: key);

  @override
  State<MonthChips> createState() => _MonthChipsState();
}

class _MonthChipsState extends State<MonthChips> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  month = 1;
                });
              },
              child: const Text('Jan')),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  month = 2;
                });
              },
              child: const Text('Feb')),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  month = 3;
                });
              },
              child: const Text('Mar')),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  month = 4;
                });
              },
              child: const Text('April')),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  month = 5;
                });
              },
              child: const Text('May')),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  month = 6;
                });
              },
              child: const Text('June')),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  month = 7;
                });
              },
              child: const Text('July')),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  month = 8;
                });
              },
              child: const Text('August')),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  month = 9;
                });
              },
              child: const Text('Sept')),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  month = 10;
                });
              },
              child: const Text('Oct')),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  month = 11;
                });
              },
              child: const Text('Nov')),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  month = 12;
                });
              },
              child: const Text('Dec')),
        ],
      ),
    );
  }
}
