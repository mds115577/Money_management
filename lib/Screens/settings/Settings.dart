import 'package:flutter/cupertino.dart';
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
            child: Container(
              height: 380,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 175, 171, 171),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30, top: 50, bottom: 8),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      height: 38,
                      child: ListTile(
                        onTap: () {
                          clrscr();
                        },
                        leading: Padding(
                          padding: const EdgeInsets.only(bottom: 18.0),
                          child: Text(
                            'Reset App',
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
                      height: 38,
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
                    Visibility(
                      visible: status == false ? false : true,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          height: 48,
                          child: ListTile(
                            onTap: () async {
                              await timePicked(context);
                            },
                            leading: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Timer',
                                style: GoogleFonts.inconsolata(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(bottom: 38.0),
                              child: IconButton(
                                iconSize: 30,
                                onPressed: () {},
                                icon: const Icon(
                                  CupertinoIcons.timer,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      height: 38,
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
                      height: 38,
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
          ),
        ],
      )),
    );
  }

  clrscr() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    await TransactionDB.instance.transClear();
    await CategoryDB.instance.categoryClear();
    Restart.restartApp();
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
