import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

// ignore: must_be_immutable
class PieChartsExpense extends StatelessWidget {
  PieChartsExpense({Key? key}) : super(key: key);
  Map<String, double> dataMap = {
    "Fashion": 55,
    "Business": 44,
  };

  final colorList = <Color>[
    Colors.greenAccent,
    const Color.fromARGB(255, 206, 221, 36)
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 240,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 120, 107, 107),
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
            child: PieChart(
              dataMap: dataMap,
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              centerText: 'Expense',
              chartRadius: MediaQuery.of(context).size.width / 3.01,
              colorList: colorList,
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 32,
              legendOptions: const LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: false,
                decimalPlaces: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
