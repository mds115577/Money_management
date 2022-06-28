import 'package:get/get.dart';
//import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_1_money_management/Screens/Adding_items/Widgets/date_picker.dart';

import '../models/category_model.dart';
import '../models/transactions_model.dart';

// ignore: constant_identifier_names
const TRANSACTION_DB_NAME = 'transaction-db';

class TransactionDbFunctions extends GetxController {
  // Future<void> addTransaction(TransactionModel obj);
  // Future<List<TransactionModel>> getAllTransactions();
  // Future<void> deleteTransactions(String id);
  // Future<void> updateTransact(TransactionModel value);
  // Future<void> transClear();
  // Future<void> filterList(String selected);

// class TransactionDB implements TransactionDbFunctions {
//   TransactionDB.internal();
//   static TransactionDB instance = TransactionDB.internal();
//   factory TransactionDB() {
//     return instance;
//   }
  RxList<TransactionModel> transactionListNotifier = <TransactionModel>[].obs;
  RxList<TransactionModel> incometransactionListNotifier =
      <TransactionModel>[].obs;
  RxList<TransactionModel> expennsetransactionListNotifier =
      <TransactionModel>[].obs;
  RxList<TransactionModel> filterListNotifier = <TransactionModel>[].obs;
  RxList<TransactionModel> incomeFilterlist = <TransactionModel>[].obs;
  RxList<TransactionModel> expenseFilterlist = <TransactionModel>[].obs;
  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    db.put(obj.id, obj);
  }

  @override
  Future<void> refresh() async {
    final _alltransaction = await getAllTransactions();
    _alltransaction.sort((first, second) => second.date.compareTo(first.date));

    expennsetransactionListNotifier.clear();
    incometransactionListNotifier.clear();
    transactionListNotifier.clear();
    Future.forEach(
      _alltransaction,
      (TransactionModel transaction) {
        if (transaction.type == CategoryType.income) {
          incometransactionListNotifier.add(transaction);
        } else {
          expennsetransactionListNotifier.add(transaction);
        }
      },
    );

    transactionListNotifier.addAll(_alltransaction);
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return db.values.toList();
  }

  @override
  Future<void> deleteTransactions(String id) async {
    final _transactDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    _transactDB.delete(id);
    refresh();
  }

  @override
  Future<void> updateTransact(TransactionModel value) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    db.put(value.id, value);
    transactionListNotifier.clear();
    refresh();
  }

  @override
  Future<void> transClear() async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await db.clear();
  }

  @override
  filterList(String selected) async {
    DateTime now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (selected == 'Today') {
      return sortedList(today);
    } else if (selected == 'Yesterday') {
      return sortedList(yesterday);
    } else if (selected == 'Month') {
      return sortedMonth(today);
    }
    update();
  }

  Future<void> sortedList(DateTime _selected) async {
    incomeFilterlist.clear();
    expenseFilterlist.clear();
    filterListNotifier.clear();
    for (TransactionModel data in transactionListNotifier) {
      if (data.date.day == _selected.day &&
          data.date.month == selected!.month &&
          data.type == CategoryType.income) {
        incomeFilterlist.add(data);
        filterListNotifier.add(data);

        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

      } else if (data.date.day == _selected.day &&
          data.date.month == selected!.month &&
          data.type == CategoryType.expense) {
        expenseFilterlist.add(data);

        filterListNotifier.add(data);
      }
      update();
    }
  }

  sortedMonth(DateTime _selected) async {
    incomeFilterlist.clear();
    expenseFilterlist.clear();
    filterListNotifier.clear();
    for (TransactionModel datas in transactionListNotifier) {
      if (datas.date.month == _selected.month &&
          datas.category.type == CategoryType.income) {
        incomeFilterlist.add(datas);
        filterListNotifier.add(datas);
      } else {
        expenseFilterlist.add(datas);
        filterListNotifier.add(datas);
      }
    }
    update();
  }

  sortedCustom(DateTime startDate, DateTime endDate) async {
    incomeFilterlist.clear();
    expenseFilterlist.clear();
    filterListNotifier.clear();
    for (TransactionModel data in transactionListNotifier) {
      if (data.date.day >= startDate.day &&
          data.date.day <= endDate.day &&
          data.date.month >= startDate.month &&
          data.date.month <= endDate.month &&
          data.category.type == CategoryType.income) {
        incomeFilterlist.add(data);
        filterListNotifier.add(data);
      } else if (data.date.day >= startDate.day &&
          data.date.day <= endDate.day &&
          data.date.month >= startDate.month &&
          data.date.month <= endDate.month &&
          data.category.type == CategoryType.expense) {
        expenseFilterlist.add(data);
        filterListNotifier.add(data);
      }
    }
  }
}
