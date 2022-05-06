import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 32, 32),
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
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: 320,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 175, 171, 171),
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
                    SizedBox(height: 18),
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
                    SizedBox(height: 18),
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
                    SizedBox(height: 18),
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
                    SizedBox(height: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
