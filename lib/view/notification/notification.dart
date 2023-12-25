// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:build/controller/constant.dart';
import 'package:build/controller/erroralert.dart';
import 'package:build/main.dart';
import 'package:build/model/noti.dart';
import 'package:build/view/FirstSevice/first_service.dart';
import 'package:build/Language/language.dart';
import 'package:build/view/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool isLoading = true;
  List<Noti> notificatiosList = [];
  @override
  void initState() {
    getnotifications();
    super.initState();
  }

  getnotifications() async {
    var headers2 = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${currentUser.token}'
    };
    try {
      var request = await http.get(Uri.parse('$baseUrl/notifications'),
          headers: headers2);

      if (request.statusCode == 200) {
        List data = json.decode(request.body);
        for (var element in data) {
          notificatiosList.add(Noti(
              id: element["id"].toString(),
              titleAr: element["titleAr"],
              titleEn: element["titleEn"],
              messageAr: element["messageAr"],
              messageEn: element["messageEn"],
              createdAt: element["createdAt"],
              createdAtAr: element["createdAtAr"]));
        }
        setState(() {
          isLoading = false;
        });
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const MainPage(pageIndex: 0)),
            (route) => false);
        erroralert(context, "حدث خطأ يرجى إعادة المحاولة");
      }
    } catch (e) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainPage(pageIndex: 0)),
          (route) => false);
      erroralert(context, "حدث خطأ يرجى إعادة المحاولة");
    }
  }

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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translateText["Notifications"]![language],
                        style: textStyle2(),
                      ),
                      /*
                      Icon(
                        language == 0
                            ? Icons.arrow_back_ios_new
                            : Icons.arrow_forward_ios,
                        size: 35,
                      )*/
                    ],
                  ),
                ),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: maincolor,
                      ))
                    : Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            for (int i = 0; i < notificatiosList.length; i++)
                              noteBox(
                                  language == 0
                                      ? notificatiosList[i].titleAr
                                      : notificatiosList[i].titleEn,
                                  language == 0
                                      ? notificatiosList[i].messageAr
                                      : notificatiosList[i].messageEn,
                                  language == 0
                                      ? notificatiosList[i].createdAtAr
                                      : notificatiosList[i].createdAt),
                          ],
                        ),
                      ),
                Container(
                  height: 70,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget noteBox(String title, String content, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffAA277B),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Text(
                content,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              Align(
                  alignment: language == 0
                      ? Alignment.bottomLeft
                      : Alignment.bottomRight,
                  child: Text(
                    time,
                    style: TextStyle(
                        color: Colors.white.withOpacity(.8), fontSize: 16),
                  )),
              Container(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
