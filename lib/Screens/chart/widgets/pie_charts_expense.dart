import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/db/transaction_db.dart';
import 'package:project_1_money_management/models/transactions_model.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:flutter/material.dart';

class PieChartsExpense extends StatefulWidget {
  const PieChartsExpense({Key? key}) : super(key: key);

  @override
  State<PieChartsExpense> createState() => _PieChartsExpenseState();
}

class _PieChartsExpenseState extends State<PieChartsExpense> {
  final TransactionDbFunctions _cont = Get.put(TransactionDbFunctions());
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Chartdata> newChart =
        chartsort(_cont.expennsetransactionListNotifier.value);
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 33.h,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 175, 171, 171),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(
                    1,
                    2,
                  ),
                  blurRadius: 8,
                  color: Color.fromARGB(255, 172, 167, 167),
                )
              ]),
          child: SfCircularChart(
              legend: Legend(isVisible: true),
              title: ChartTitle(
                  textStyle: GoogleFonts.inconsolata(
                      color: Colors.white, fontSize: 20),
                  text: 'Expense Chart'),
              series: <DoughnutSeries>[
                // Render pie chart
                DoughnutSeries<Chartdata, String>(
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    dataSource: newChart,
                    xValueMapper: (Chartdata data, _) => data.categories,
                    yValueMapper: (Chartdata data, _) => data.amount)
              ]),
        ),
      ],
    );
  }

  List<Chartdata> chartsort(List<TransactionModel> model) {
    double value;
    String catagoryname;
    List visted = [];
    List<Chartdata> newData = [];

    for (var i = 0; i < model.length; i++) {
      visted.add(0);
    }

    for (var i = 0; i < model.length; i++) {
      value = model[i].amount;
      catagoryname = model[i].category.name;

      for (var j = i + 1; j < model.length; j++) {
        if (model[i].category.name == model[j].category.name) {
          value += model[j].amount;
          visted[j] = -1;
        }
      }

      if (visted[i] != -1) {
        setState(() {
          newData.add(Chartdata(categories: catagoryname, amount: value));
        });
      }
    }

    return newData;
  }
}

class Chartdata {
  String? categories;
  double? amount;
  Chartdata({required this.categories, required this.amount});
}
