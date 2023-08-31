import 'package:build/view/FirstSevice/first_service.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 55,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "تنبيهاتي",
                      style: textStyle2(),
                    ),
                    const Icon(
                      Icons.arrow_back_ios_new,
                      size: 35,
                    )
                  ],
                ),
              ),
              noteBox("مراجعه مخططات الإنشائية",
                  "جاري تنفيذ الطلب وباقي 8 ايام عمل ", "منذ يوم"),
              noteBox("ابحث عن مقاول",
                  "جاري تنسيق اجتماع مع المقاول وفريق أبني ", "منذ 3  ساعات"),
            ],
          ),
        ),
      ),
    );
  }

  Widget noteBox(String title, String content, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 130,
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
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    time,
                    style: TextStyle(
                        color: Colors.white.withOpacity(.8), fontSize: 16),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
