import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/Screens/Settings/notification.dart';
import 'package:project_1_money_management/db/category_db.dart';
import 'package:project_1_money_management/db/transaction_db.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool status = false;
  bool vals = false;
  static TimeOfDay initialTime = TimeOfDay.now();
  @override
  void initState() {
    super.initState();
    NotificationApi().init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.listen(onClickedNotification);
  onClickedNotification(String? payload) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (route) => const BottomAppBar()));
  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    // TimeOfDay? time;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 32, 32),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 18),
            child: Text(
              'Settings',
              style: GoogleFonts.inconsolata(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30, top: 50, bottom: 8),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    height: height / 16,
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: AutoSizeText(
                          'Reset App',
                          style: GoogleFonts.inconsolata(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: Switch(
                          value: vals,
                          onChanged: (value) {
                            setState(() {
                              vals = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: vals == false ? false : true,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    clrscr();
                                  },
                                  child: const Text('Yes')),
                              const SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      vals = false;
                                    });
                                  },
                                  child: const Text('No'))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: vals == true ? false : true,
                      child: const SizedBox(height: 18)),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    height: height / 16,
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: Text(
                          'Notifications',
                          style: GoogleFonts.inconsolata(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: Switch(
                          value: status,
                          onChanged: (val) {
                            setState(() {
                              status = val;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const Visibility(
                      child: SizedBox(
                    height: 10,
                  )),
                  Visibility(
                    visible: status == false ? false : true,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      height: height / 16,
                      child: ListTile(
                        onTap: () async {
                          await timePicked(context);
                        },
                        leading: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: AutoSizeText(
                            'Set Timer',
                            style: GoogleFonts.inconsolata(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    height: height / 16,
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: Text(
                          'About',
                          style: GoogleFonts.inconsolata(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    height: height / 16,
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: Text(
                          'Version 1.0',
                          style: GoogleFonts.inconsolata(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       NotificationApi.showNotification(
                  //           body: 'come on man',
                  //           payload: 'come on man',
                  //           title: 'simple');
                  //     },
                  //     child: const Text('sdf'))
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  timePicked(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (newTime != null && newTime != initialTime) {
      {
        NotificationApi.showScheduledNotifications(
            body: 'Time to Keep the track',
            scheduledTime: Time(newTime.hour, newTime.minute, 0),
            payload: 'come on man',
            title: 'Floyd Money');
      }
    }
    showTopSnackBar(
      context,
      const CustomSnackBar.success(
        message: "Notification is Setted Succesfully",
      ),
    );
  }
}

clrscr() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  await TransactionDB.instance.transClear();
  await CategoryDB.instance.categoryClear();
  Restart.restartApp();
}
