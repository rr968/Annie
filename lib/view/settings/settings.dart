// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:build/controller/constant.dart';
import 'package:build/view/FirstSevice/first_service.dart';
import 'package:build/view/settings/conditions.dart';
import 'package:build/view/settings/suggestions.dart';
import 'package:build/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../controller/snackbar.dart';
import '../../main.dart';
import '../../Language/language.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: language == 0 ? TextDirection.rtl : TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          translateText["Settings"]![language],
                          style: textStyle2(),
                        ),
                        /*  Icon(
                          language == 0
                              ? Icons.arrow_back_ios_new
                              : Icons.arrow_forward_ios,
                          size: 35,
                        )*/
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                image: !currentUser.image.contains("https://")
                                    ? DecorationImage(
                                        image:
                                            FileImage(File(currentUser.image)),
                                        fit: BoxFit.cover)
                                    : DecorationImage(
                                        image: NetworkImage(currentUser.image),
                                        fit: BoxFit.cover),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      spreadRadius: 0,
                                      blurRadius: 6,
                                      color: Color.fromARGB(255, 138, 138, 138))
                                ],
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "  ${currentUser.name}",
                                  style: textStyle2(),
                                ),
                                Text(
                                  "     ${currentUser.email}",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        language == 0
                            ? Icons.arrow_back_ios_new
                            : Icons.arrow_forward_ios,
                        color: const Color.fromARGB(255, 194, 194, 194),
                        size: 30,
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translateText["Connect_us"]![language],
                        style: textStyle3(),
                      ),
                      Image.asset(
                        "assets/arrowdown.png",
                        height: 15,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 5,
                              color: Colors.grey)
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  translateText["mobNum"]![language],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: maincolor,
                                      fontSize: 15),
                                ),
                                Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Text(
                                      contactPhone,
                                      style: normalTextStyle(),
                                    )),
                              ],
                            ),
                            Container(
                              height: 13,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  translateText["company_email"]![language],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: maincolor,
                                      fontSize: 15),
                                ),
                                Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Text(
                                      contactEmail,
                                      style: normalTextStyle(),
                                    )),
                              ],
                            ),
                            Container(
                              height: 13,
                            ),
                            FittedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    translateText["social_accounts"]![language],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: maincolor,
                                        fontSize: 14),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Image.asset(
                                          "assets/in.png",
                                          height: 30,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Image.asset(
                                          "assets/twitter.png",
                                          height: 30,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Image.asset(
                                          "assets/facebook.png",
                                          height: 30,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translateText["About_application"]![language],
                        style: textStyle3(),
                      ),
                      Icon(
                        language == 0
                            ? Icons.arrow_back_ios_new
                            : Icons.arrow_forward_ios,
                        color: const Color.fromARGB(255, 194, 194, 194),
                        size: 30,
                      )
                    ],
                  ),
                  Container(
                    height: 18,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Conditions()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          translateText["Terms_Conditions"]![language],
                          style: textStyle3(),
                        ),
                        Icon(
                          language == 0
                              ? Icons.arrow_back_ios_new
                              : Icons.arrow_forward_ios,
                          color: const Color.fromARGB(255, 194, 194, 194),
                          size: 30,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 18,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Suggestions()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          translateText["suggestions"]![language],
                          style: textStyle3(),
                        ),
                        Icon(
                          language == 0
                              ? Icons.arrow_back_ios_new
                              : Icons.arrow_forward_ios,
                          color: const Color.fromARGB(255, 194, 194, 194),
                          size: 30,
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      try {
                        var headers = {
                          'Accept': 'application/json',
                          'Content-Type': 'application/json',
                          'Authorization': 'Bearer ${currentUser.token}'
                        };
                        var request =
                            http.Request('POST', Uri.parse('$baseUrl/logout'));

                        request.headers.addAll(headers);

                        http.StreamedResponse response = await request.send();
                        if (response.statusCode == 200) {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.clear().then((value) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Splash()),
                                (route) => false);
                          });
                        } else {
                          snackbar(context,
                              translateText["internetError"]![language]);
                        }
                      } catch (e) {
                        snackbar(
                            context, translateText["internetError"]![language]);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        translateText["sign_out"]![language],
                        style: TextStyle(
                            color: maincolor,
                            decoration: TextDecoration.underline,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
