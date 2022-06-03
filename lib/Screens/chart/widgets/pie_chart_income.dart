import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/db/transaction_db.dart';
import 'package:project_1_money_management/models/transactions_model.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:flutter/material.dart';

class IncomeChart extends StatefulWidget {
  const IncomeChart({Key? key}) : super(key: key);

  @override
  State<IncomeChart> createState() => _IncomeChartState();
}

class _IncomeChartState extends State<IncomeChart> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      TransactionDB.instance.refresh();
    });

    final List<Chartdata> newchart =
        chartsort(TransactionDB.instance.incometransactionListNotifier.value);
    return Column(
      children: [
        const SizedBox(
          height: 10,
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
            child: ValueListenableBuilder(
                valueListenable:
                    TransactionDB.instance.incometransactionListNotifier,
                builder: (BuildContext context, List<TransactionModel> list,
                    Widget? _) {
                  return SfCircularChart(
                      legend: Legend(isVisible: true),
                      title: ChartTitle(
                          textStyle: GoogleFonts.inconsolata(
                              color: Colors.white, fontSize: 20),
                          text: 'Income Chart'),
                      series: <DoughnutSeries>[
                        // Render pie chart
                        DoughnutSeries<Chartdata, String>(
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            dataSource: newchart,
                            xValueMapper: (Chartdata data, _) =>
                                data.categories,
                            yValueMapper: (Chartdata data, _) => data.amount)
                      ]);
                })),
      ],
    );
  }

  List<Chartdata> chartsort(List<TransactionModel> model) {
    double value;
    String catagoryname;
    List visited = [];
    List<Chartdata> newData = [];

    for (var i = 0; i < model.length; i++) {
      visited.add(0);
    }

    for (var i = 0; i < model.length; i++) {
      value = model[i].amount;
      catagoryname = model[i].category.name;

      for (var j = i + 1; j < model.length; j++) {
        if (model[i].category.name == model[j].category.name) {
          value = value + model[j].amount;
          visited[j] = -1;
        }
      }

      if (visited[i] != -1) {
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






























// import 'package:flutter/material.dart';
// import 'package:project_1_money_management/db/transaction_db.dart';
// import 'package:project_1_money_management/models/data_map_model.dart';


// // ignore: must_be_immutable
// class PieCharts extends StatelessWidget {
//   PieCharts({Key? key}) : super(key: key);
 

//   final colorList = <Color>[
//     Colors.greenAccent,
//     const Color.fromARGB(255, 206, 221, 36),
//     const Color.fromARGB(247, 185, 0, 0),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final List<DataMapModle> chartData = [
            
//         ];
//     maps();
//     return Center(
//         child:SfCircularChart(
//                       legend: Legend(isVisible: true),
//                       title: ChartTitle(text: 'Half yearly sales analysis'),
//                       series: <DoughnutSeries>[
//                         // Render pie chart
//                         DoughnutSeries<Chartdata, String>(
//                             dataLabelSettings:
//                                 const DataLabelSettings(isVisible: true),
//                             dataSource: connectedList,
//                             xValueMapper: (Chartdata data, _) =>
//                                 data.categories,
//                             yValueMapper: (Chartdata data, _) => data.amount)
//                       ]));
//   }

//   maps() {
//     final List<DataMapModle> datamapList = [];
//     for (var item
//         in TransactionDB.instance.incometransactionListNotifier.value) {
//       datamapList.add(
//         DataMapModle(
//           amount: item.amount,
//           name: item.category.name,
//         ),
//       );
//     }
    
// }











// // Column(
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.all(15.0),
// //           child: Container(
// //             height: 240,
// //             decoration: BoxDecoration(
// //                 color: const Color.fromARGB(255, 120, 107, 107),
// //                 borderRadius: BorderRadius.circular(10),
// //                 boxShadow: const [
// //                   BoxShadow(
// //                     offset: Offset(
// //                       1,
// //                       2,
// //                     ),
// //                     blurRadius: 8,
// //                     color: Color.fromARGB(255, 172, 167, 167),
// //                   )
// //                 ]),
// //             child: PieChart(
// //               dataMap: maps(),
// //               animationDuration: const Duration(milliseconds: 800),
// //               chartLegendSpacing: 32,
// //               centerText: 'Income',
// //               chartRadius: MediaQuery.of(context).size.width / 3.01,
// //               colorList: colorList,
// //               initialAngleInDegree: 0,
// //               chartType: ChartType.ring,
// //               ringStrokeWidth: 32,
// //               legendOptions: const LegendOptions(
// //                 showLegendsInRow: false,
// //                 legendPosition: LegendPosition.right,
// //                 showLegends: true,
// //                 legendTextStyle: TextStyle(
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               chartValuesOptions: const ChartValuesOptions(
// //                 showChartValueBackground: true,
// //                 showChartValues: true,
// //                 showChartValuesInPercentage: true,
// //                 showChartValuesOutside: false,
// //                 decimalPlaces: 1,
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );