import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_1_money_management/Screens/Adding_items/Widgets/date_picker.dart';

import '../models/category_model.dart';
import '../models/transactions_model.dart';

// ignore: constant_identifier_names
const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransactions(String id);
  Future<void> updateTransact(TransactionModel value);
  Future<void> transClear();
  Future<void> filterList(String selected);
}

class TransactionDB implements TransactionDbFunctions {
  TransactionDB.internal();
  static TransactionDB instance = TransactionDB.internal();
  factory TransactionDB() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> incometransactionListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> expennsetransactionListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> filterListNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> incomeFilterlist = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> expenseFilterlist = ValueNotifier([]);
  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _alltransaction = await getAllTransactions();
    _alltransaction.sort((first, second) => second.date.compareTo(first.date));

    expennsetransactionListNotifier.value.clear();
    incometransactionListNotifier.value.clear();
    transactionListNotifier.value.clear();
    Future.forEach(
      _alltransaction,
      (TransactionModel transaction) {
        if (transaction.type == CategoryType.income) {
          incometransactionListNotifier.value.add(transaction);
        } else {
          expennsetransactionListNotifier.value.add(transaction);
        }
      },
    );
    filterListNotifier.notifyListeners();
    transactionListNotifier.value.addAll(_alltransaction);
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    transactionListNotifier.notifyListeners();
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    incometransactionListNotifier.notifyListeners();
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    expennsetransactionListNotifier.notifyListeners();
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
    transactionListNotifier.value.clear();
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
  }

  Future<void> sortedList(DateTime _selected) async {
    incomeFilterlist.value.clear();
    expenseFilterlist.value.clear();
    filterListNotifier.value.clear();
    for (TransactionModel data in transactionListNotifier.value) {
      if (data.date.day == _selected.day &&
          data.date.month == selected!.month &&
          data.type == CategoryType.income) {
        incomeFilterlist.value.add(data);
        filterListNotifier.value.add(data);
        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        filterListNotifier.notifyListeners();
        incomeFilterlist.notifyListeners();
      } else if (data.date.day == _selected.day &&
          data.date.month == selected!.month &&
          data.type == CategoryType.expense) {
        expenseFilterlist.value.add(data);

        filterListNotifier.value.add(data);
        filterListNotifier.notifyListeners();
        expenseFilterlist.notifyListeners();
      }
    }
  }

  sortedMonth(DateTime _selected) async {
    incomeFilterlist.value.clear();
    expenseFilterlist.value.clear();
    filterListNotifier.value.clear();
    for (TransactionModel datas in transactionListNotifier.value) {
      if (datas.date.month == _selected.month &&
          datas.category.type == CategoryType.income) {
        incomeFilterlist.value.add(datas);
        filterListNotifier.value.add(datas);
        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        incomeFilterlist.notifyListeners();
        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        filterListNotifier.notifyListeners();
      } else {
        expenseFilterlist.value.add(datas);
        filterListNotifier.value.add(datas);
        filterListNotifier.notifyListeners();
        expenseFilterlist.notifyListeners();
      }
    }
  }

  sortedCustom(DateTime startDate, DateTime endDate) async {
    incomeFilterlist.value.clear();
    expenseFilterlist.value.clear();
    filterListNotifier.value.clear();
    for (TransactionModel data in transactionListNotifier.value) {
      if (data.date.day >= startDate.day &&
          data.date.day <= endDate.day &&
          data.date.month >= startDate.month &&
          data.date.month <= endDate.month &&
          data.category.type == CategoryType.income) {
        incomeFilterlist.value.add(data);
        filterListNotifier.value.add(data);
      } else if (data.date.day >= startDate.day &&
          data.date.day <= endDate.day &&
          data.date.month >= startDate.month &&
          data.date.month <= endDate.month &&
          data.category.type == CategoryType.expense) {
        expenseFilterlist.value.add(data);
        filterListNotifier.value.add(data);
      }
    }
  }
}
