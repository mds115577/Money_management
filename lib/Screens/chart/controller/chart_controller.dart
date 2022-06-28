import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_1_money_management/db/transaction_db.dart';

class ChartController extends GetxController {
  List<String> items = ['All', 'Today', 'Yesterday', 'Month', 'Custom'];
  final TransactionDbFunctions _cont = Get.put(TransactionDbFunctions());
  DateTimeRange? selecteds;
  DateTime newsel = DateTime.now();
  DateTime startDate = DateTime.now().add(const Duration(days: -5));
  DateTime endDate = DateTime.now();
  DateTimeRange? range;

  selectDate(BuildContext context) async {
    final _initialDate = DateTimeRange(
        start: DateTime.now().add(const Duration(days: -2)),
        end: DateTime.now());
    selecteds = (await showDateRangePicker(
      context: context,
      initialDateRange: range ?? _initialDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ));

    if (selecteds == null) {
      return;
    } else {
      range = selecteds!;
      startDate = range!.start;
      endDate = range!.end;
    }
    _cont.sortedCustom(startDate, endDate);
    selecteds == null;
    update();
  }

  String dropdownValue = 'All';
  dropdownExpense(dynamic context, String? value) {
    dropdownValue = value!;

    if (dropdownValue == 'Custom') {
      selectDate(context);
    } else {
      _cont.filterList(dropdownValue);
    }
    _cont.filterListNotifier.refresh();
    update();
  }

//----------------income------------//
  String dropdownValue2 = 'All';
  DateTimeRange? selecteds2;
  DateTime newsel2 = DateTime.now();
  DateTime startDate2 = DateTime.now().add(const Duration(days: -5));
  DateTime endDate2 = DateTime.now();
  DateTimeRange? range2;
  selectDate2(BuildContext context) async {
    final _initialDate = DateTimeRange(
        start: DateTime.now().add(const Duration(days: -2)),
        end: DateTime.now());
    selecteds2 = (await showDateRangePicker(
      context: context,
      initialDateRange: range2 ?? _initialDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ));

    if (selecteds2 == null) {
      return;
    } else {
      range = selecteds2!;
      startDate = range2!.start;
      endDate = range2!.end;
    }
    _cont.sortedCustom(startDate2, endDate2);
    selecteds2 == null;
  }

  dropDownIncome(BuildContext context, String? value) {
    dropdownValue2 = value!;
    dropdownValue2 == 'Custom'
        ? selectDate2(context)
        : _cont.filterList(dropdownValue2);
    _cont.filterListNotifier.refresh();
    update();
  }
}
