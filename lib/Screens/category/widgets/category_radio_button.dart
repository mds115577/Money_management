import 'package:flutter/material.dart';

import '../../../models/category_model.dart';

ValueNotifier<CategoryType> selectedCategory =
    ValueNotifier(CategoryType.income);

// ignore: camel_case_types
class Category_Radio extends StatelessWidget {
  final String name;
  final CategoryType type;
  final Color color;
  final Color activecolor;

  const Category_Radio({
    Key? key,
    required this.name,
    required this.color,
    required this.activecolor,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedCategory,
      builder: (BuildContext context, CategoryType newCategory, Widget? _) {
        return (RadioListTile<CategoryType>(
          groupValue: newCategory,
          title: Text(
            name,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          value: type,
          onChanged: (value) {
            if (value == null) {
              return;
            } else {
              selectedCategory.value = value;
              // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
              selectedCategory.notifyListeners();
            }
          },
          activeColor: activecolor,
        ));
      },
    );
  }
}
