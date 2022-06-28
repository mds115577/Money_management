import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_1_money_management/db/category_db.dart';
import 'package:project_1_money_management/db/transaction_db.dart';
import 'package:project_1_money_management/models/category_model.dart';
import 'package:project_1_money_management/screens/home/controller/home_controller.dart';
import 'package:sizer/sizer.dart';
import 'Refactors/splash_screen.dart';
import 'models/transactions_model.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final CategoryController _catcont = Get.put(CategoryController());
  final HomeController _homecont = Get.put(HomeController());
  final TransactionDbFunctions _cont = Get.put(TransactionDbFunctions());
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  tz.initializeTimeZones();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(const MyApp());
  });
  _catcont.refreshUI();
  _homecont.getName();
  await _cont.getAllTransactions();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: ScreenSplash(),
        );
      },
    );
  }
}
