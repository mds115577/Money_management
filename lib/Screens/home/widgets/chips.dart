import 'package:flutter/material.dart';
import 'package:project_1_money_management/db/transaction_db.dart';
import 'package:project_1_money_management/models/transactions_model.dart';

class MonthChips extends StatefulWidget {
  const MonthChips({Key? key}) : super(key: key);

  @override
  State<MonthChips> createState() => _MonthChipsState();
}

String? month;

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
                  month = 'Jan';
                  sortedMonths(month!);
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
                  month = 'Feb';
                  sortedMonths(month!);
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
                  month = 'Mar';
                  sortedMonths(month!);
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
                  month = 'April';
                  sortedMonths(month!);
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
                  month = 'May';
                  sortedMonths(month!);
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
                  month = 'June';
                  sortedMonths(month!);
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
                  month = 'July';
                  sortedMonths(month!);
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
                  month = 'August';
                  sortedMonths(month!);
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
                  month = 'Sept';
                  sortedMonths(month!);
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
                  month = 'Oct';
                  sortedMonths(month!);
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
                  month = 'Nov';
                  sortedMonths(month!);
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
                  month = 'Dec';
                  sortedMonths(month!);
                });
              },
              child: const Text('Dec')),
        ],
      ),
    );
  }

  sortedMonths(String month) async {
    TransactionDB.instance.filterListNotifier.value.clear();

    for (TransactionModel item
        in TransactionDB.instance.filterListNotifier.value) {
      if (item.date.month == DateTime.january && month == 'Jan') {
        setState(() {
          TransactionDB.instance.filterListNotifier.value.add(item);
          TransactionDB.instance.filterListNotifier.notifyListeners();
        });
      } else if (item.date.month == DateTime.may && month == 'May') {
        setState(() {
          TransactionDB.instance.filterListNotifier.value.add(item);
          TransactionDB.instance.filterListNotifier.notifyListeners();
        });
      }
    }
  }
}
