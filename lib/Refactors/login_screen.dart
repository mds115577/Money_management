import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_money_management/Refactors/bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class UserName extends StatelessWidget {
  UserName({Key? key}) : super(key: key);

  TextEditingController usernameController = TextEditingController();
  final userKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 32, 32),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
        child: ListView(
          children: [
            const SizedBox(
              height: 80,
            ),
            Center(
              child: Text(
                'Floyd Money',
                style: GoogleFonts.inconsolata(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 50.0,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 175, 171, 171),
                  borderRadius: BorderRadius.circular(20)),
              height: 270,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          'What sould we call you ?',
                          style: GoogleFonts.inconsolata(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: userKey,
                      child: TextFormField(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter a name';
                          } else {
                            return null;
                          }
                        },
                        controller: usernameController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: ('  Enter Your Name'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 35, 32, 32),
                            // Text Color
                          ),
                          onPressed: () {
                            if (userKey.currentState!.validate()) {
                              userNameStore(usernameController.text, context);
                            }
                          },
                          label: const Text(
                            'Get Started..',
                            style: TextStyle(
                                fontFamily: 'Kanit',
                                // fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          icon: const Icon(
                            FontAwesomeIcons.circleArrowRight,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> userNameStore(String name, context) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('username', name);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomBar()));
  }
}
