import 'package:flutter/material.dart';

class ExpenseCategory extends StatelessWidget {
  const ExpenseCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 175, 171, 171),
            borderRadius: BorderRadius.circular(20)),
        child: Expanded(
          child: ListView.separated(
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30, top: 8, bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    height: 40,
                    child: ListTile(
                      leading: Text('Shopping'),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, index) {
                return SizedBox(
                  height: 5,
                );
              },
              itemCount: 4),
        ),
      ),
    );
  }
}
