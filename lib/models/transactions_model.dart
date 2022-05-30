import 'package:hive_flutter/adapters.dart';

import 'category_model.dart';
part 'transactions_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final double amount;
  @HiveField(1)
  final String purpose;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  CategoryType? type;
  @HiveField(4)
  final CategoryModel category;
  @HiveField(5)
  final String? id;
  TransactionModel({
    required this.amount,
    required this.purpose,
    required this.category,
    required this.date,
    this.type,
    this.id,
  });
}
