// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:build/controller/constant.dart';
import 'package:build/controller/erroralert.dart';
import 'package:build/main.dart';
import 'package:build/model/request.dart';
import 'package:build/view/FirstSevice/first_service.dart';
import 'package:build/Language/language.dart';
import 'package:build/view/mainpage.dart';
import 'package:build/view/offers/offers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainListOffers extends StatefulWidget {
  const MainListOffers({super.key});

  @override
  State<MainListOffers> createState() => _MainListOffersState();
}

class _MainListOffersState extends State<MainListOffers> {
  bool isLoading = true;
  List<Request> requestList = [];
  @override
  void initState() {
    getMyRequest();
    super.initState();
  }

  getMyRequest() async {
    var headers2 = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${currentUser.token}'
    };
    try {
      var request = await http.get(
          Uri.parse('$baseUrl/my-pending-offer-selection-requests'),
          headers: headers2);

      if (request.statusCode == 200) {
        List data = json.decode(request.body);

        for (var element in data) {
          requestList.add(Request(
            id: element["id"],
            serviceId: element["serviceId"],
            serviceName: element["serviceName"],
            serviceNameEn: element["serviceNameEn"],
            status: element["status"],
            statusMsg: element["statusMsg"],
            statusMsgEn: element["statusMsgEn"],
          ));
        }
        setState(() {
          isLoading = false;
        });
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
            (route) => false);
        erroralert(context, "حدث خطأ يرجى إعادة المحاولة");
      }
    } catch (e) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
          (route) => false);
      erroralert(context, "حدث خطأ يرجى إعادة المحاولة");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        body: Directionality(
          textDirection: language == 0 ? TextDirection.rtl : TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translateText["offers"]![language],
                        style: textStyle2(),
                      ),
                      /*   Icon(
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
                        child: CircularProgressIndicator(color: maincolor),
                      )
                    : requestList.isEmpty
                        ? const Text("لا يوجد عروض بعد")
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                for (int i = 0; i < requestList.length; i++)
                                  noteBox(
                                    language == 0
                                        ? requestList[i].serviceName
                                        : requestList[i].serviceNameEn,
                                    requestList[i].id,
                                    requestList[i].serviceId,
                                    language == 0
                                        ? requestList[i].statusMsg
                                        : requestList[i].statusMsgEn,
                                  ),
                              ],
                            ),
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget noteBox(String title, int id, int requestId, String status) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Offers(
                      requestId: id,
                      serviceId: requestId,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
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
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Align(
                            alignment: language == 0
                                ? Alignment.bottomLeft
                                : Alignment.bottomRight,
                            child: FittedBox(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: maincolor,
                                    /* status == "تم التنفيذ"
                                        ? const Color(0xff4C2963)
                                        : status == "ملغي"
                                            ? const Color(0xffE91C00)
                                            : const Color(0xff21E900),*/
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Text(
                                      translateText["Click_to_see_offers"]![
                                          language],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment:
                  language == 0 ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 40,
                  width: 120,
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
                      translateText["orderNum"]![language] + id.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
