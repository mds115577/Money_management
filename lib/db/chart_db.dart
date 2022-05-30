import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_1_money_management/Screens/Chart/widgets/pie_chart_income.dart';
import 'package:project_1_money_management/models/data_map_model.dart';

abstract class Chartdata_db {
  Future<void> addData(DataMapModel value);
  Future<List<DataMapModel>> gettransaction();
  Future<void> deleteingTransactions(DataMapModel Id);
}

class chartDB implements Chartdata_db {
  ValueNotifier<List<DataMapModel>> Chartnsnotfier = ValueNotifier([]);

  @override
  Future<void> addData(DataMapModel value) async {
    final _db = await Hive.openBox<DataMapModel>("Chartdata_db");
    _db.put(value.id, value);
    refresh();
  }

  Future refresh() async {
    final value = await gettransaction();
    Chartnsnotfier.value.clear();
    Chartnsnotfier.value.addAll(value);
    Chartnsnotfier.notifyListeners();
  }

  @override
  Future<void> deleteingTransactions(DataMapModel Id) async {
    final _db = await Hive.openBox<DataMapModel>("Chartdata_db");
  }

  @override
  Future<List<DataMapModel>> gettransaction() async {
    final _db = await Hive.openBox<DataMapModel>("Chartdata_db");
    return _db.values.toList();
  }

  // Future<void> Sort() async {
  //   int visited;
  //   List<Chartdata> seperateCategory = [];
  //   for (var i = 0; i < list.length; i++) {
  //     visited.add(0);
  //   }

  //   for (var i = 0; i < list.length; i++) {
  //     amount = list[i].amount;
  //     category = list[i].catagry.name;

  //     for (var j = i + 1; j < list.length; j++) {
  //       if (list[i].catagry.name == list[j].catagry.name) {
  //         amount += list[j].amount;
  //         visited[j] = -1;
  //       }
  //     }
  //   }
  // }
}
