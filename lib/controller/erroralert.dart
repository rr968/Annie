// ignore_for_file: use_build_context_synchronously

import 'package:build/controller/snackbar.dart';
import 'package:build/Language/language.dart';
import 'package:http/http.dart' as http;
import 'package:build/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/splash.dart';
import 'constant.dart';

erroralert(context, text) {
  showDialog(
      context: context,
      builder: (context) {
        return FittedBox(
          child: AlertDialog(
            title: Column(
              children: [
                SizedBox(
                    height: 90,
                    child: Image.asset(
                      "assets/cancel.png",
                      fit: BoxFit.fill,
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  " خطأ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
              ],
            ),
            content: Column(
              children: [
                Center(child: Text(text)),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30),
                      // border: Border.all(color: Colors.black, width: 2)
                    ),
                    child: Center(
                        child: Text(
                      translateText["OK"]![language],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

sendAlert(context) {
  showDialog(
      context: context,
      builder: (context) {
        return FittedBox(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            title: Column(
              children: [
                SizedBox(
                    height: 130,
                    child: Image.asset(
                      "assets/send.gif",
                      fit: BoxFit.fill,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "تم ارسال ايميل لبريدك الإلكتروني",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: maincolor),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      });
}

deleteAlert(context) {
  showDialog(
      context: context,
      builder: (context) {
        return FittedBox(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              title: Column(
                children: [
                  SizedBox(
                      height: 100,
                      child: Image.asset(
                        "assets/send.gif",
                        fit: BoxFit.fill,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "هل تريد حذف حسابك؟",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: maincolor),
                  ),
                  Container(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () async {
                          try {
                            var headers = {
                              'Authorization': 'Bearer ${currentUser.token}'
                            };
                            var request = http.Request(
                                'DELETE', Uri.parse('$baseUrl/users/delete'));

                            request.headers.addAll(headers);

                            var response = await request.send();

                            if (response.statusCode == 204) {
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
                              Navigator.pop(context);
                              snackbar(context,
                                  translateText["internetError"]![language]);
                            }
                          } catch (_) {
                            Navigator.pop(context);
                            snackbar(context,
                                translateText["internetError"]![language]);
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: maincolor),
                          child: const Center(
                              child: Text(
                            "نعم",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xffAA277B),
                                  Color(0xff4C2963),
                                ],
                              ),
                              color: maincolor),
                          child: const Center(
                              child: Text(
                            "لا",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

contactAlert(context) {
  showDialog(
      context: context,
      builder: (context) {
        String num = contactPhone;
        String text = """
 +5 لأن عدد الطوابق 
يرجى التواصل معنا على الرقم
$num
""";
        return FittedBox(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            title: Column(
              children: [
                SizedBox(
                    height: 130,
                    child: Image.asset(
                      "assets/send.gif",
                      fit: BoxFit.fill,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: maincolor),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                      color: maincolor,
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(color: Colors.black, width: 2)
                    ),
                    child: Center(
                        child: Text(
                      translateText["OK"]![language],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      });
}

noteAlert(context, String text1, fun) {
  showDialog(
      context: context,
      builder: (context) {
        return FittedBox(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              title: Column(
                children: [
                  SizedBox(
                      height: 100,
                      child: Image.asset(
                        "assets/note.gif",
                        fit: BoxFit.fill,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    text1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: maincolor),
                  ),
                  Container(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: fun,
                        child: Container(
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: maincolor),
                          child: const Center(
                              child: Text(
                            "حسناً",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xffAA277B),
                                  Color(0xff4C2963),
                                ],
                              ),
                              color: maincolor),
                          child: const Center(
                              child: Text(
                            "لا",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
