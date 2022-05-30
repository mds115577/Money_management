import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_1_money_management/models/category_model.dart';
import 'package:project_1_money_management/models/transactions_model.dart';
part 'data_map_model.g.dart';

@HiveType(typeId: 4)
class DataMapModel {
  @HiveField(1)
  final CategoryModel category;
  @HiveField(2)
  final TransactionModel all;
  @HiveField(3)
  final Color? color;
  @HiveField(4)
  final String id;
  DataMapModel(
      {required this.category,
      required this.all,
      required this.color,
      required this.id});
}
