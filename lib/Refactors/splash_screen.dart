import 'package:flutter/material.dart';
import 'package:project_1_money_management/Refactors/bottom_bar.dart';
import 'package:project_1_money_management/Refactors/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 32, 32),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: height / 2,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkLogin() async {
    final pref = await SharedPreferences.getInstance();
    final loggedName = pref.getString('username');
    if (loggedName == null) {
      gotoLogin();
    } else {
      await Future.delayed(const Duration(seconds: 4));
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx1) => ScreenNavigation()));
    }
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => UserName()));
  }
}
