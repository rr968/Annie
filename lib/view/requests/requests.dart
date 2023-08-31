import 'package:build/view/FirstSevice/first_service.dart';
import 'package:flutter/material.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 55,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "طلباتي",
                      style: textStyle2(),
                    ),
                    const Icon(
                      Icons.arrow_back_ios_new,
                      size: 35,
                    )
                  ],
                ),
              ),
              noteBox("ابحث عن مقاول", "طلب رقم # 01", "تم التنفيذ"),
              noteBox(
                  "مراجعه مخططات شركه القمه", "طلب رقم # 001", "قيد التنفيذ"),
              noteBox("مراجعه مخططات شركه القمه", "طلب رقم # 001", "ملغي"),
            ],
          ),
        ),
      ),
    );
  }

  Widget noteBox(String title, String id, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              height: 115,
              decoration: BoxDecoration(
                  color: const Color(0xffAA277B),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 30, bottom: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                              color: status == "تم التنفيذ"
                                  ? const Color(0xff4C2963)
                                  : status == "ملغي"
                                      ? const Color(0xffE91C00)
                                      : const Color(0xff21E900),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              status,
                              style: TextStyle(
                                  color: status == "قيد التنفيذ"
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 15),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 40,
              width: 110,
              decoration: BoxDecoration(
                  color: const Color(0xffAA277B),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(1, 4),
                        spreadRadius: 0,
                        blurRadius: 5,
                        color: Colors.black45)
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  id,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
